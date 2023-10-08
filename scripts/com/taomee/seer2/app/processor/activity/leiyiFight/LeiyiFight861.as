package com.taomee.seer2.app.processor.activity.leiyiFight
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.config.TimeLimitConfig;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class LeiyiFight861
   {
      
      private static var _resourceLoader:ResourceLibraryLoader;
      
      private static var _resLib:ResourceLibrary;
      
      private static var _fightStatus:uint;
       
      
      private var _map:MapModel;
      
      private var _cloudMC:MovieClip;
      
      private var _leiyi:MovieClip;
      
      private var _currTime:uint;
      
      public function LeiyiFight861(param1:MapModel)
      {
         super();
         this._map = param1;
         this.init();
         this.initEvent();
      }
      
      private function init() : void
      {
         this._cloudMC = this._map.content["cloud_mc"];
         this._currTime = this.getTime;
         if(this.getTime == 1)
         {
            this._cloudMC.gotoAndStop(2);
            if(SceneManager.prevSceneType == SceneType.ARENA && _fightStatus == 1)
            {
               _fightStatus = 0;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winOne(1);
               }
               else
               {
                  this.noWinOne(1);
               }
               return;
            }
            this.playOne();
         }
         else if(this.getTime == 2)
         {
            this._cloudMC.visible = false;
            if(SceneManager.prevSceneType == SceneType.ARENA && _fightStatus == 1)
            {
               _fightStatus = 0;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winOne(2);
               }
               else
               {
                  this.noWinOne(2);
               }
               return;
            }
            this.playTwo();
         }
         else
         {
            this._cloudMC.visible = true;
            this._cloudMC.gotoAndStop(1);
         }
      }
      
      private function initEvent() : void
      {
         if(PetInfoManager.hasEventListener(PetInfoEvent.SERVER_GET_PET) == false)
         {
            PetInfoManager.addEventListener(PetInfoEvent.SERVER_GET_PET,this.onServerGetPet);
         }
         this._map.content.addEventListener(Event.ENTER_FRAME,this.onEnter);
      }
      
      private function onEnter(param1:Event) : void
      {
         if(this._currTime == this.getTime)
         {
            return;
         }
         if(this.getTime == 1)
         {
            this._currTime = 1;
            this.playOne();
         }
         else if(this.getTime == 2)
         {
            this._currTime = 2;
            this.playTwo();
         }
         else if(this.getTime == 4)
         {
            SceneManager.changeScene(SceneType.LOBBY,133);
         }
      }
      
      private function onServerGetPet(param1:PetInfoEvent) : void
      {
         var event:PetInfoEvent = param1;
         PetInfoManager.removeEventListener(PetInfoEvent.SERVER_GET_PET,this.onServerGetPet);
         if(event.content == 90)
         {
            MovieClipUtil.playFullScreen("res/activity/animation/leiyiFight/leiyiComplete.swf",function():void
            {
               LayerManager.resetOperation();
            });
         }
      }
      
      private function winOne(param1:uint) : void
      {
         var index:uint = param1;
         this.playLoad(function():void
         {
            showLeiyi();
            if(index == 2)
            {
               _leiyi.removeEventListener(MouseEvent.CLICK,onLeiyi);
               _leiyi.gotoAndStop(52);
               _leiyi.buttonMode = true;
               _leiyi.addEventListener(MouseEvent.CLICK,onLeiyiTwo);
            }
         });
      }
      
      private function noWinOne(param1:uint) : void
      {
         var index:uint = param1;
         this.showLeiyi();
         this.playLoad(function():void
         {
            var _mcDian:MovieClip = null;
            _mcDian = getMC("fight");
            LayerManager.topLayer.addChild(_mcDian);
            _mcDian.x = ActorManager.getActor().x;
            _mcDian.y = ActorManager.getActor().y;
            ActorManager.getActor().hide();
            MovieClipUtil.playMc(_mcDian,1,_mcDian.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_mcDian);
               ActorManager.getActor().show();
               if(index == 1)
               {
                  NpcDialog.show(477,"雷伊",[[0,"怎么？小小挫折就想放弃？能者就是坚持了弱者所放弃的！（14:30——15:00天气可能有变化，会削弱雷伊的能量）"]],["我一定会成为强者！继续挑战！","我准备好再来！"],[function():void
                  {
                     _fightStatus = 1;
                     FightManager.startFightWithWild(90);
                  }]);
               }
               else
               {
                  NpcDialog.show(477,"雷伊",[[0,"屡败屡战，这才是一个强者所必须具备的锲而不舍！（战胜就可以得到独一无二的雷神雷伊）"]],["我一定会成为强者！继续挑战！","我准备好再来！"],[function():void
                  {
                     _fightStatus = 1;
                     FightManager.startFightWithWild(91);
                  },function():void
                  {
                     _leiyi.removeEventListener(MouseEvent.CLICK,onLeiyi);
                     _leiyi.buttonMode = true;
                     _leiyi.addEventListener(MouseEvent.CLICK,onLeiyiTwo);
                  }]);
               }
            },true);
         });
      }
      
      private function playOne() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_FIGHT,this.getServer,false);
      }
      
      private function getServer(param1:ServerBuffer) : void
      {
         var bufIndex:int = 0;
         var server:ServerBuffer = param1;
         bufIndex = server.readDataAtPostion(0);
         this.playLoad(function():void
         {
            if(bufIndex != 1)
            {
               MovieClipUtil.playFullScreen("res/activity/animation/leiyiFight/leiyiOpen.swf",function():void
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.LEIYI_FIGHT,0,1);
                  showLeiyi();
               },true,false,2);
            }
            else
            {
               showLeiyi();
            }
         });
      }
      
      private function showLeiyi() : void
      {
         DisplayUtil.removeForParent(this._leiyi);
         this._leiyi = this.getMC("leiyiOpen");
         LayerManager.uiLayer.addChild(this._leiyi);
         this._leiyi.gotoAndStop(this._leiyi.totalFrames);
         this._leiyi.buttonMode = true;
         this._leiyi.addEventListener(MouseEvent.CLICK,this.onLeiyi);
      }
      
      private function onLeiyi(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(477,"雷伊",[[0,"你是我宿命的敌手吗？不是你倒下！就是我倒下！准备好了吗？（战胜就可以得到雷神雷伊）"]],["恭候已久！作战吧！","准备好再来找你！"],[function():void
         {
            _fightStatus = 1;
            FightManager.startFightWithWild(90);
         }]);
      }
      
      private function playTwo() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_FIGHT,this.getServerTwo,false);
      }
      
      private function getServerTwo(param1:ServerBuffer) : void
      {
         var bufIndex:int = 0;
         var server:ServerBuffer = param1;
         bufIndex = server.readDataAtPostion(1);
         this.playLoad(function():void
         {
            _cloudMC.gotoAndStop(3);
            showLeiyi();
            _leiyi.removeEventListener(MouseEvent.CLICK,onLeiyi);
            if(bufIndex != 1)
            {
               MovieClipUtil.playMc(_leiyi,2,52,function():void
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.LEIYI_FIGHT,1,1);
                  _leiyi.buttonMode = true;
                  _leiyi.addEventListener(MouseEvent.CLICK,onLeiyiTwo);
               },true);
            }
            else
            {
               _leiyi.gotoAndStop(52);
               _leiyi.buttonMode = true;
               _leiyi.addEventListener(MouseEvent.CLICK,onLeiyiTwo);
            }
         });
      }
      
      private function onLeiyiTwo(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(477,"雷伊",[[0,"能量的削弱了！但是我也不是这么好对付的！（战胜就可以得到独一无二的雷神雷伊）"]],["恭候已久！作战吧！","打个酱油~一会再来！"],[function():void
         {
            _fightStatus = 1;
            FightManager.startFightWithWild(91);
         }]);
      }
      
      private function playLoad(param1:Function) : void
      {
         var url:String = null;
         var loadComplete:Function = param1;
         if(_resourceLoader)
         {
            loadComplete();
         }
         else
         {
            url = String(URLUtil.getActivityAnimation("leiyiFight/leiyiFight"));
            _resourceLoader = new ResourceLibraryLoader(url);
            _resourceLoader.getLib(function(param1:ResourceLibrary):void
            {
               _resLib = param1;
               loadComplete();
            });
         }
      }
      
      protected function getMC(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return _resLib.getMovieClip(param1);
         }
         return null;
      }
      
      private function get getTime() : uint
      {
         if(TimeLimitConfig.InLimitTime(32))
         {
            return 1;
         }
         if(TimeLimitConfig.InLimitTime(33))
         {
            return 2;
         }
         if(TimeLimitConfig.isStartFront(32))
         {
            return 0;
         }
         return 3;
      }
      
      public function dispose() : void
      {
         this._map.content.removeEventListener(Event.ENTER_FRAME,this.onEnter);
         if(this._leiyi)
         {
            this._leiyi.removeEventListener(MouseEvent.CLICK,this.onLeiyi);
            this._leiyi.removeEventListener(MouseEvent.CLICK,this.onLeiyiTwo);
         }
         DisplayUtil.removeForParent(this._leiyi);
         this._leiyi = null;
         this._cloudMC = null;
         this._map = null;
      }
   }
}
