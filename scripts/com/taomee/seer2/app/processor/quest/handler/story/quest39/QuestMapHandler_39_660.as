package com.taomee.seer2.app.processor.quest.handler.story.quest39
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_39_660 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _mc_3:MovieClip;
      
      private var _mc_4:MovieClip;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_39_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(5) as Teleport;
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this._teleport.visible = false;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._teleport.visible = false;
            this.intMc();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initMc();
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "39_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"啊！！财务官！！他要干啥！！？！"]],["这么鬼鬼祟祟的样子！！"],[function():void
               {
                  DisplayUtil.removeForParent(_mc_0);
                  _mc_0 = _processor.resLib.getMovieClip("mc_1");
                  _map.front.addChild(_mc_0);
                  MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                     QuestManager.accept(_quest.id);
                  },true);
               }]);
            },true);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.stewardTalk();
      }
      
      private function stewardTalk() : void
      {
         NpcDialog.show(97,"财务官",[[0,"呵——呵——呃……这不是星际使者和萨伯尔兵团长嘛……今天天气挺好的，怎么样，在看风景聊天吗"]],[" 你再装好了……"],[function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[2,"很抱歉，财务官大人……不，我似乎不应该在这么称呼你了。总督大人已经明令逮捕你！放弃抵抗，束手就擒吧！"]],["嗯，嗯！"],[function():void
            {
               NpcDialog.show(97,"财务官",[[0,"逮捕我？我想你是搞错了吧？？呵——呵——咳，为了飞翼氏族的财务，我也献出过青春，不算我是功臣，居然还要逮捕我？"]],["你脸皮是有多厚啊……"],[function():void
               {
                  NpcDialog.show(83,"萨伯尔兵团长",[[2,"我也不愿意这样……抱歉了！！"]],["抓住他！抓住他！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                        QuestManager.completeStep(_quest.id,1);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function intMc() : void
      {
         if(this._mc_0 != null)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         this._mc_1 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         _map.ground.addChild(this._mc_1);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onStewardTalk);
      }
      
      private function onStewardTalk(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(97,"财务官",[[0,"呵——呵——呃……这不是星际使者和萨伯尔兵团长嘛……今天天气挺好的，怎么样，在看风景聊天吗"]],[" 你再装好了……"],[function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[2,"很抱歉，财务官大人……不，我似乎不应该在这么称呼你了。总督大人已经明令逮捕你！放弃抵抗，束手就擒吧！"]],["嗯，嗯！"],[function():void
            {
               NpcDialog.show(97,"财务官",[[0,"逮捕我？我想你是搞错了吧？？呵——呵——咳，为了飞翼氏族的财务，我也献出过青春，不算我是功臣，居然还要逮捕我？"]],["你脸皮是有多厚啊……"],[function():void
               {
                  NpcDialog.show(83,"萨伯尔兵团长",[[2,"我也不愿意这样……抱歉了！！"]],["抓住他！抓住他！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                        QuestManager.completeStep(_quest.id,1);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepConpleteHandler(param1:QuestEvent) : void
      {
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onStewardTalk);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         this._teleport.visible = true;
         SceneManager.changeScene(SceneType.LOBBY,720);
      }
      
      private function initMc() : void
      {
         this._mc_3 = _processor.resLib.getMovieClip("mc_8");
         this._mc_4 = _processor.resLib.getMovieClip("mc_9");
         _map.content.addChild(this._mc_3);
         _map.content.addChild(this._mc_4);
         this._mc_4.addEventListener(MouseEvent.CLICK,this.onStewardTalkAgain);
      }
      
      private function onStewardTalkAgain(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(97,"财务官",[[1,"缇娜女王陛下！我已经按照约定完成了任务，现在带我走吧！"]],["会带你走才怪……"],[function():void
         {
            NpcDialog.show(39,"缇娜",[[1,"你在做梦吗？我怎么不记得我说过要带你走？"]],["看吧……"],[function():void
            {
               NpcDialog.show(97,"财务官",[[2,"不对，不对啊……女王陛下，你是在开玩笑吧？呵——呵——女王陛下真有幽默感……"]],["丢脸丢到家了……"],[function():void
               {
                  _mc_4.removeEventListener(MouseEvent.CLICK,onStewardTalkAgain);
                  DisplayUtil.removeForParent(_mc_3);
                  DisplayUtil.removeForParent(_mc_4);
                  _mc_0 = _processor.resLib.getMovieClip("mc_10");
                  _map.front.addChild(_mc_0);
                  MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                  {
                     NpcDialog.show(107,"总督大人",[[0,"叛徒……你简直丢尽飞翼氏族的颜面！！还不退下！"]],["哇塞！总督大人驾到！！"],[function():void
                     {
                        NpcDialog.show(80,"葛蕾芬兵团长",[[0,"背叛者……死！！"]],["突然感觉有安全感多了……"],[function():void
                        {
                           NpcDialog.show(39,"缇娜",[[1,"你们还能得意多久呢？博士已经封印了神兽的力量，所有的精灵都会陷入虚弱状态。哦——呵呵呵！"]],["斯坦因说的拘束器……难道是？！"],[function():void
                           {
                              NpcDialog.show(80,"葛蕾芬兵团长",[[0,"葛雷芬……无法被呼唤出来……"]],["这，这？！"],[function():void
                              {
                                 NpcDialog.show(83,"萨伯尔兵团长",[[0,"糟糕！萨伯尔也是！！"]],["哎？！？！？！"],[function():void
                                 {
                                    DisplayUtil.removeForParent(_mc_0);
                                    _mc_1 = _processor.resLib.getMovieClip("mc_11");
                                    _map.front.addChild(_mc_1);
                                    MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
                                    {
                                       NpcDialog.show(87,"刚铎",[[0,"将未来托付给他人，只能证明自己的软弱！！"]],["嗯，嗯！"],[function():void
                                       {
                                          NpcDialog.show(107,"总督大人",[[0,"刚铎……我知道，你一定会出现。但是他们已经拘束了神兽的力量，赤手空拳的我们还能够做什么？"]],["对啊，精灵都没办法使用。"],[function():void
                                          {
                                             NpcDialog.show(87,"刚铎",[[1,"有赤手空拳就够了。我来告诉你，靠自己的力量可以做到什么吧！"]],["可以做到什么？"],[function():void
                                             {
                                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_1"),function():void
                                                {
                                                   NpcDialog.show(39,"缇娜",[[3,"什么……困住神兽的拘束器被解开了？！不可能！！"]],["难道说……？！"],[function():void
                                                   {
                                                      MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_2"),function():void
                                                      {
                                                         NpcDialog.show(107,"总督大人",[[0,"刚铎，我想，我开始理解你当年对我说的话了。"]],["总督，当年究竟发生了什么？"],[function():void
                                                         {
                                                            NpcDialog.show(107,"总督大人",[[0,"星际使者，我很感激你为飞翼氏族所做的一切。我想这么多年来我做的最正确的决定，就是信任了你。"]],["喂，不要回避我的问题嘛。"],[function():void
                                                            {
                                                               NpcDialog.show(87,"刚铎",[[0,"哦~~是谁！扰乱了我的思绪……是谁！！走进了我的生命~~所以，下次再说！"]],["又来？！？！"],[function():void
                                                               {
                                                                  QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                                                                  QuestManager.completeStep(_quest.id,4);
                                                               }]);
                                                            }]);
                                                         }]);
                                                      },true,false,2);
                                                   }]);
                                                },true,false,2);
                                             }]);
                                          }]);
                                       }]);
                                    },true);
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(param1.questId == 39)
         {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
            DisplayUtil.removeForParent(this._mc_3);
            DisplayUtil.removeForParent(this._mc_4);
         }
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mc_1);
         DisplayUtil.removeForParent(this._mc_2);
         DisplayUtil.removeForParent(this._mc_3);
         DisplayUtil.removeForParent(this._mc_4);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
      }
   }
}
