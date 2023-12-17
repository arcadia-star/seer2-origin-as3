package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actives.active_1.ActivePopUp;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.SyncEvent;
   
   public class ActiveProcess_1 extends BaseActiveProcess
   {
      
      private static const ACTIVE_TYPE:int = 100000;
       
      
      private var _currentGame:Sprite;
      
      private var _fightIndex:int;
      
      private var _step:int = 0;
      
      public function ActiveProcess_1()
      {
         super();
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         var result:uint = 0;
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this._fightIndex != 1 && this._fightIndex != 2 && this._fightIndex != 3)
            {
               return;
            }
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
            result = FightManager.fightWinnerSide;
            if(result == FightSide.RIGHT)
            {
               this.overStep(false);
               this._fightIndex = 0;
            }
            else if(result == FightSide.LEFT)
            {
               ActivePopUp.popBox(_resLib,this._fightIndex,function():void
               {
                  if(_fightIndex == 3)
                  {
                     NpcDialog.show(434,"（皮格妈妈）",[[0,"你这个小捣蛋鬼，给我等着，我还会再来的！"]],["我奉陪"]);
                  }
                  else
                  {
                     overStep(true);
                  }
                  _fightIndex = 0;
               });
            }
         }
      }
      
      private function overStep(param1:Boolean) : void
      {
         var isSuccess:Boolean = param1;
         if(isSuccess)
         {
            ++this._step;
            NpcDialog.show(429,"伊特",[[0,"干得漂亮！保持这个势头啊，我开始有点喜欢上你这个家伙了~嘻嘻"]],["继续挑战","稍等片刻"],[function():void
            {
               doStep();
            },null]);
         }
         else
         {
            NpcDialog.show(429,"伊特",[[0,"你怎么这么弱啊？这样可没法和我做朋友哦，要不要再试一次看看？"]],["我准备好了","再等会"],[function():void
            {
               doStep();
            },null]);
         }
      }
      
      override public function start() : void
      {
         var serverDate:Date = null;
         serverDate = new Date(TimeManager.getServerTime() * 1000);
         var time:int = serverDate.getHours() * 60 + serverDate.getMinutes();
         if(time < 12 * 60 || time > 20 * 60 || time < 18 * 60 && time > 14 * 60)
         {
            this.notOpen();
            return;
         }
         ServerBufferManager.getServerBuffer(ACTIVE_TYPE,function(param1:ServerBuffer):void
         {
            var buff:ServerBuffer = param1;
            var lastDate:Date = new Date(buff.data.readUnsignedInt() * 1000);
            var i:int = 0;
            while(i < 5)
            {
               _step += buff.readDataAtPostion(4 + i);
               i++;
            }
            if(lastDate.getFullYear() != serverDate.getFullYear() || lastDate.getMonth() != serverDate.getMonth() || lastDate.getDate() != serverDate.getDate())
            {
               _step = 0;
            }
            else if(_step == 5)
            {
               if(lastDate.getFullYear() == serverDate.getFullYear() && lastDate.getMonth() == serverDate.getMonth() && lastDate.getDate() == serverDate.getDate())
               {
                  notOpen();
                  return;
               }
               _step = 0;
            }
            loadResouse(1,function():void
            {
               doStep();
            });
         },false);
      }
      
      private function notOpen() : void
      {
         NpcDialog.show(429,"伊特",[[0,"现在捣蛋反攻战每天12:00-14:00、18:00-20:00开启，每天只能完成一次哦！"]],["再等会"]);
      }
      
      private function doStep() : void
      {
         switch(this._step)
         {
            case 0:
               this.stepOne();
               break;
            case 1:
               this.stepTwo();
               break;
            case 2:
               this.stepThree();
               break;
            case 3:
               this.stepFour();
               break;
            case 4:
               this.stepFive();
         }
      }
      
      private function stepOne() : void
      {
         NpcDialog.show(429,"伊特",[[0,"矮冬瓜，我就知道你会来帮我的！准备好了吗？他们就快来了。"]],["我准备好了","再等会"],[function():void
         {
            ActivePopUp.popup(_resLib,1,function():void
            {
               UILoader.load("res/active/exteral/1_0.swf",LoadType.SWF,function(param1:ContentInfo):void
               {
                  _currentGame = param1.content;
                  _currentGame.addEventListener("over",onGameOver);
                  LayerManager.topLayer.addChild(_currentGame);
                  LayerManager.hideMap();
               });
            });
         },null]);
      }
      
      private function onGameOver(param1:SyncEvent) : void
      {
         this._currentGame.removeEventListener("over",this.onGameOver);
         DisplayObjectUtil.removeFromParent(this._currentGame);
         LayerManager.showMap();
         if(param1.changeList[0] == 0)
         {
            this.overStep(false);
         }
         else
         {
            ServerBufferManager.updataSvrExpandBuffer(ACTIVE_TYPE,this._step + 1,1);
            this.overStep(true);
         }
         this._currentGame = null;
      }
      
      private function stepTwo() : void
      {
         var mc:MovieClip = null;
         mc = _resLib.getMovieClip("npc_431");
         LayerManager.mapLayer.addChild(mc);
         this._fightIndex = 1;
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            NpcDialog.show(431,"格尔西克",[[0,"既然被拜托了这事情我就不能这么不管了，你这小子是要帮他出头吗？"]],["我这忙帮定了","我还没准备好"],[function():void
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
               FightManager.startFightWithWild(25);
            },null]);
            DisplayObjectUtil.removeFromParent(mc);
            mc = null;
         },true);
      }
      
      private function stepThree() : void
      {
         ActivePopUp.popup(_resLib,2,function():void
         {
            UILoader.load("res/active/exteral/1_1.swf",LoadType.SWF,function(param1:ContentInfo):void
            {
               _currentGame = param1.content;
               _currentGame.addEventListener("over",onGameOver);
               LayerManager.topLayer.addChild(_currentGame);
               LayerManager.hideMap();
            });
         });
      }
      
      private function stepFour() : void
      {
         var mc:MovieClip = null;
         mc = _resLib.getMovieClip("npc_433");
         LayerManager.mapLayer.addChild(mc);
         this._fightIndex = 2;
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            NpcDialog.show(433,"（两只蛋壳鸡）",[[0,"我们两兄弟可不是好惹的，你最好还是别和我们作对，我们要找的是对面那小家伙！"]],["我这忙帮定了","我还没准备好"],[function():void
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
               FightManager.startFightWithWild(26);
            },null]);
            DisplayObjectUtil.removeFromParent(mc);
            mc = null;
         },true);
      }
      
      private function stepFive() : void
      {
         this._fightIndex = 3;
         MovieClipUtil.playFullScreen("res/active/fullScreen/1_0.swf",function():void
         {
            NpcDialog.show(432,"（皮皮格战队）",[[0,"我们是皮皮格战队，像你这样的助纣为虐的恶人必须受到正义的制裁！"]],["我这忙帮定了","我还没准备好"],[function():void
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
               FightManager.startFightWithWild(27);
            },null]);
         });
      }
   }
}
