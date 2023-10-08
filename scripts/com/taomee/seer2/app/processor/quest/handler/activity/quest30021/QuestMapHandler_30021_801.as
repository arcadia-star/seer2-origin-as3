package com.taomee.seer2.app.processor.quest.handler.activity.quest30021
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30021_801 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _npc_0:MovieClip;
      
      private var _npc_1:MovieClip;
      
      private var _npc_2:MovieClip;
      
      public function QuestMapHandler_30021_801(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.playFullMC();
         }
      }
      
      private function playFullMC() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30021_1"),function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"三个队长口中的神秘人都大不相同，不知道今晚会有什么发现呢？"]],["这个重大的秘密就有我来揭开吧！"],[function():void
            {
               _mc_0 = _processor.resLib.getMovieClip("mc_0");
               _map.front.addChild(_mc_0);
               MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"=。=喂，那位黑漆漆的同学，你当我不存在啊？"]],["（看来是上尉口中描述的那个神秘人嘛！）"],[function():void
                  {
                     _mc_1 = _processor.resLib.getMovieClip("mc_1");
                     _map.front.addChild(_mc_1);
                     MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"=。=喂，你们都当我不存在啊？"]],["好吧其实我是来埋伏的……"],[function():void
                        {
                           if(_mc_0)
                           {
                              DisplayUtil.removeForParent(_mc_0);
                           }
                           if(_mc_1)
                           {
                              DisplayUtil.removeForParent(_mc_1);
                           }
                           _mc_0 = _processor.resLib.getMovieClip("mc_2");
                           _map.front.addChild(_mc_0);
                           MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                           {
                              NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"你，你你你！你是S！凯萨，还有，你不是争霸赛的奖励精灵嘛！！你们怎么会搅在一起的！！"]],["争霸赛难道有内幕？？？？！！！"],[function():void
                              {
                                 NpcDialog.show(503,"神秘的某某",[[0,"不是，我，我才不是和他们一伙的！"]],["那你们怎么同时出现在这里，还鬼鬼祟祟的！"],[function():void
                                 {
                                    NpcDialog.show(503,"神秘的某某",[[0,"我，我是来把神秘队伍的积分条擦掉的……"]],["咦？"],[function():void
                                    {
                                       NpcDialog.show(14,"S",[[1,"我想怎么每次把积分写上去，第二天都会莫名消失，原来是你干的好事？！炎帝，杀了它——"]],["神秘队伍是萨伦帝国的队伍？你们有什么企图？"],[function():void
                                       {
                                          NpcDialog.show(14,"S",[[1,"哼哼，我如此美貌，却没有选我做队长？我要你们付出代价！"]],["你心眼也太小了吧？！"],[function():void
                                          {
                                             NpcDialog.show(499,"凯萨",[[0,"既然是全员竞技，一定可以遇见很强的对手。除此以外别无其他。"]],["好吧这个理由还算正当……"],[function():void
                                             {
                                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30021_2"),function():void
                                                {
                                                   NpcDialog.show(14,"S",[[1,"啧，不愧是奖励精灵，实力不容小觑嘛！"]],["（看起来胆小，但是很强力！）"],[function():void
                                                   {
                                                      NpcDialog.show(499,"凯萨",[[0,"有趣，有趣……既然这样，我要赢得争霸赛，然后光明正大和你打一场！！"]],["不是吧，凯萨要加入争霸赛……"],[function():void
                                                      {
                                                         QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                                                         QuestManager.completeStep(_quest.id,3);
                                                      }]);
                                                   }]);
                                                },true,false,2);
                                             }]);
                                          }]);
                                       }]);
                                    }]);
                                 }]);
                              }]);
                           },true);
                        }]);
                     },true);
                  }]);
               },true);
            }]);
         },false,false,2);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         SceneManager.changeScene(SceneType.LOBBY,80);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
