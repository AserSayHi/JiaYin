package views.games
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import controllers.MC;
	
	import models.PosVO;
	
	import starling.display.Image;
	
	import utils.FlashAssets;
	import utils.Voice;
	
	import views.components.RecordButton;

	public class Game_AppleBanana extends BasicGame
	{
		public function Game_AppleBanana()
		{
			super();
		}
		
		//用来管理swf中的资源
		private var fAssets:FlashAssets;
		//当前怪物形象动画
		private var monster:MovieClip;
		//怪物动作库
		private var actions:Dictionary;
		//识别按钮
		private var btn_record:RecordButton;
		//连续错误次数
		private var wrongTime:int = 0;
		//当前图标
		private var icon:MovieClip;
		
		override public function initialize():void
		{
			fAssets = FlashAssets.getInstance( FlashAssets.GAMES );
			if(!controller.checkIfGuide())		//有指引时，表示资源已在指引阶段加载完成
				fAssets.loadSWF( "assets/swfs/apple_banana.swf", init );
			else
				init();
		}
		
		override public function restart():void
		{
			controller.hideResultBoard();
			btn_record.visible = true;
			monster.visible = true;
			start();
		}
		
		private function init():void
		{
			//初始化语音识别词库
			Voice.instance.updateRecognizerLexcion("apple_banana_a_b");
			
			//初始化
			initBG();
			initBtns();
			initMonster();
			initIcons();
			//初始化完成
			initCompleted();
		}
		
		private function initMonster():void
		{
			actions = new Dictionary();
			const actionNames:Array = ["stand", "r_0", "r_1", "r_2", "w_0", "w_1", "w_2"];
			
			var mc:MovieClip;
			for each(var name:String in actionNames)
			{
				mc = fAssets.getMovieClipByName( "monster_"+name ) as MovieClip;
				mc.mouseChildren = mc.mouseEnabled = false;
				MC.instance.addToStage2D( mc );
				mc.x = PosVO.REAL_WIDTH >> 1;
				mc.y = PosVO.REAL_HEIGHT -100;
				mc.scaleX = mc.scaleY = 2;
				mc.visible = false;
				mc.gotoAndStop(1);
				if(name != "stand")
					mc.addFrameScript(mc.totalFrames-1, onLastFrame);
				actions[name] = mc;
			}
			monster = actions.stand;
			monster.play();
			monster.visible = true;
		}
		
		//初始化识别按钮
		private function initBtns():void
		{
			btn_record = new RecordButton();
			btn_record.setResultFunction( onResult, onStartRecog );
			MC.instance.addToStage2D( btn_record );
			btn_record.x = btn_record.width/2;
			btn_record.y = PosVO.REAL_HEIGHT - btn_record.height/2;
			btn_record.visible = false;
			btn_record.mouseEnabled = false;
		}
		
		//图表显示队列
		private var crtList:Array;
		private var list:Array;
		private var icons:Dictionary;
		private function initIcons():void
		{
			list = ["icon_a","icon_apple","icon_b","icon_banana","icon_a","icon_apple","icon_b","icon_banana"];
			icons = new Dictionary();
			var tempIcon:MovieClip;
			var name:String;
			for(var i:int = 0; i<4; i++)
			{
				name = list[i];
				tempIcon = fAssets.getMovieClipByName(name) as MovieClip;
				tempIcon.mouseChildren = tempIcon.mouseEnabled = false;
				MC.instance.addToStage2D( tempIcon );
				tempIcon.visible = false;
				tempIcon.name = name;
				icons[name] = tempIcon;
			}
		}
		
		//初始化背景图片
		private function initBG():void
		{
			setGameBG( assets.getTexture( "mainBG" ));
			var image:Image = getImage( "image_other_0" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = 0;
			this.addChild( image );
			image.touchable = false;
			image = getImage( "image_other_1" );
			image.x = PosVO.REAL_WIDTH - image.width >> 1;
			image.y = PosVO.REAL_HEIGHT - image.height;
			this.addChild( image );
			image.touchable = false;
		}
		
		override public function start():void
		{
			this.touchable = true;
			btn_record.visible = true;
			crtList = list.slice();
			showIcon();
		}
		
		private function onStartRecog():void
		{
			btn_record.mouseEnabled = false;
		}
		private function onResult(result:String):void
		{
			if(icon == icons["icon_a"])
			{	
				recogSuccess();
				return;
			}
			if(!result)
			{
				recogFailed();
				return;
			}
			if(icons["icon_"+result] && icons["icon_"+result] == icon)
				recogSuccess();
			else
				recogFailed();
		}
		
		//识别错误
		private function recogFailed():void
		{
			trace("错误");
			monster.gotoAndStop(1);
			monster.visible = false;
			monster = actions["w_"+wrongTime];
			monster.visible = true;
			wrongTime ++;
			monster.gotoAndPlay(1);
		}
		//识别正确
		private function recogSuccess():void
		{
			trace("正确");
			//替换响应monster动画
			monster.gotoAndStop(1);
			monster.visible = false;
			monster = actions["r_"+wrongTime];
			monster.visible = true;
			//monster逐帧侦听
			monster.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			monster.gotoAndPlay(1);
			
			iconVy = 0;
			if(wrongTime == 0)
			{
				iconAy = 0;
				iconVs = .01;
			}
			else
			{
				iconAy = 5;
				iconVs = .04;
			}
			wrongTime = 0;
		}
		private var iconVy:Number = 0;
		private var iconAy:Number = 0;
		private var iconVs:Number = 0;
		
		//对应动作播放至最后一帧
		private function onLastFrame():void
		{
			trace("last frame");
			monster.gotoAndStop(1);
			monster.visible = false;
			monster = actions.stand;
			monster.visible = true;
			monster.play();
			
			if(wrongTime>0)		//错误动作
			{
				if(wrongTime >= 3)
				{
					wrongTime = 0;
					/*已错误3次，换一个水果显示*/
					crtList.push( icon.name );
					icon.visible = false;
					showIcon();
				}
				else
				{
					//动画提示AGAIN
					showAnimation();
				}
			}
			else	//正确动作
			{
				//换一个水果显示，若水果不足则提示游戏胜利
				showIcon();
			}
		}
		
		private function onEnterFrame(e:Event):void
		{
			iconVy += iconAy;
			icon.y += iconVy;
			icon.scaleX -= iconVs;
			icon.scaleY -= iconVs;
			if(monster.currentFrameLabel == "eat")
			{
				icon.visible = false;
				monster.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		private function showIcon():void
		{
			if(crtList.length == 0)	//所有题目已答题完毕
			{
				controller.showResultBoard( Math.random()*2+1 );
				btn_record.visible = false;
				monster.visible = false;
				return;
			}
			
			var name:String = crtList.shift();
			icon = icons[name];
			showAnimation();
		}
		//icon出现动画
		private function showAnimation():void
		{
			icon.visible = true;
			icon.scaleX = icon.scaleY = .2;
			icon.x = monster.x;
			icon.y = monster.y - 500;
			
			var target:Number = 1;	//缩放目标值
			var spring:Number = .95;	//弹性系数
			var friction:Number = 1.6;	//摩擦系数
			statusM.addFunc( 
				function():void{
					var vs:Number = ( target-icon.scaleX ) * spring;
					icon.scaleX += ( vs*friction );
					icon.scaleY = icon.scaleX;
				}, 50, 20, 
				function():void{
					icon.scaleX = icon.scaleY = target;
					statusM.addFunc( iconAnimation, 50 );
					btn_record.mouseEnabled = true;
				});
		}
		
		/**
		 * icon常态摇摆动画
		 */		
		private function iconAnimation():void
		{
			crtR += 20;
			if(crtR >= 360)
				crtR = crtR%360;
			icon.rotation = Math.sin( crtR * Math.PI/180 ) * 20;
		}
		private var crtR:Number = 0;
		
		override public function dispose():void
		{
			statusM.delFunc(iconAnimation);
			for(var str:String in actions)
			{
				monster = actions[str];
				if(monster)
				{
					monster.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					if(monster.parent)
						monster.parent.removeChild( monster );
					monster.stop();
				}
				delete actions[str];
			}
			actions = null;
			
			for each(var mc:MovieClip in icons)
			{
				MC.instance.delChild( mc );
			}
			icon = null;
			icons = null;
			
			if(btn_record)
			{
				MC.instance.delChild( btn_record );
				btn_record.dispose();
				btn_record = null;
			}
			monster = null;
			fAssets = null;
			super.dispose();
		}
	}
}