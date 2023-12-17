package com.taomee.seer2.app.processor.quest.handler.branch.quest10224
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10224_20 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mc6:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10224_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10224) && QuestManager.isStepComplete(10224,2) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         this._mc4["bosi"].visible = false;
         _map.front.addChild(this._mc4);
         MovieClipUtil.playMc(this._mc4,2,this._mc4.totalFrames,function():void
         {
            _mack = new AcceptableMark();
            _mack.x = _mc4["bosi"].x - 20;
            _mack.y = _mc4["bosi"].y;
            _mc4.addChild(_mack);
            _mc4["bosi"].visible = true;
            _mc4["bosi"].buttonMode = true;
            _mc4["bosi"].addEventListener(MouseEvent.CLICK,onClick);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc4["bosi"].removeEventListener(MouseEvent.CLICK,this.onClick);
         NpcDialog.show(2,"博士伊娃",[[0,"不会的！一定是我的计算出错了！怎么可能有那么荒谬的结果！"]],[" 伊娃博士怎么了？"],[function():void
         {
            NpcDialog.show(731,"奥黛丽赫本",[[0,"冷静博士……你的计算没有出错……和“王”告诉我们的预言完全相符!"]],["预言？发生什么了?!"],[function():void
            {
               NpcDialog.show(2,"博士伊娃",[[0,"你终于来了……奥黛丽赫本带来的王之预言和我这些天的观察都证明了一件事！有大事要发生了！"]],["什么事？"],[function():void
               {
                  NpcDialog.show(2,"博士伊娃",[[0,"阿卡迪亚位于的星系中有五颗与阿卡迪亚环境类似的行星，但体积略小于阿卡迪亚。"]],["恩，有听说过"],[function():void
                  {
                     NpcDialog.show(2,"博士伊娃",[[0,"而现在我们发现的事件就是……"]],[" 怎么了？"],[function():void
                     {
                        NpcDialog.show(2,"博士伊娃",[[0,"这五个行星……正在逐渐消失！"]],[" 怎么可能！"],[function():void
                        {
                           NpcDialog.show(2,"博士伊娃",[[0,"千真万确……如果计算没错的话，3个月内，五颗行星就会逐一消失，而在那之后……阿卡迪亚星也会消失在宇宙之中！"]],[" 阿卡迪亚将会消失！？"],[function():void
                           {
                              NpcDialog.show(2,"博士伊娃",[[0,"是的，最糟糕的是……这种消失……目前我们没有找到任何方法阻止它！"]],[" 无法阻止？！"],[function():void
                              {
                                 NpcDialog.show(731,"奥黛丽赫本",[[0,"伊娃博士说的没错，这和“王”临走时传达给精灵们的意志相同。"]],[" 约瑟也预言到了吗！"],[function():void
                                 {
                                    NpcDialog.show(2,"博士伊娃",[[0,"你快将这件事告诉船长，我需要在计算一遍，这是不可能的，肯定有什么地方我还没计算到……"]],["  是，伊娃博士！"],[function():void
                                    {
                                       MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10224_2"),function():void
                                       {
                                          DisplayUtil.removeForParent(_mack);
                                          DisplayUtil.removeForParent(_mc4);
                                          QuestManager.addEventListener(QuestEvent.COMPLETE,onStepComplete);
                                          QuestManager.completeStep(10224,2);
                                       },true,true);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,10);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
