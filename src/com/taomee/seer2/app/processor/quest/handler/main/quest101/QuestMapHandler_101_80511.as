package com.taomee.seer2.app.processor.quest.handler.main.quest101
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class QuestMapHandler_101_80511 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_101_80511(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
      }
      
      protected function onAccept(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         NpcDialog.show(400,"小赛尔",[[0,"恕我直言……我还真是没想到影灵兽居然是约瑟的一部分，但正因为如此，当年我看到的影灵兽与萨伦帝国的同盟又是……"]],["......"],[function():void
         {
            NpcDialog.show(3018,"伊万",[[0,"……我族一向很少在外界活动，而暗影法典则是我族严加看护的圣物。主人一定不会向外界透露它的具体消息，因为这涉及主人自身、暗影氏族、乃至整个阿卡迪亚的的秘密……"]],["......"],[function():void
            {
               NpcDialog.show(3018,"伊万",[[0,"然而事实证明，暗影氏族内部居然存在背弃了我族立场的叛徒，这让长老……很是担忧。长老决意将叛徒抓获……"]],["弗雷德爷爷真是日理万机啊……"],[function():void
               {
                  NpcDialog.show(3018,"伊万",[[0,"你是具有高度智能的……外星个体，我族选择信任“星际使者”，这次也需要你的智慧来帮助我们。"]],["......"],[function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[0,"乐意之至，那我该怎样做才能帮助你们呢？"]],["......"],[function():void
                     {
                        NpcDialog.show(3018,"伊万",[[0,"长老已经查到了这段时间里有离开暗影氏族的记录的几个人，那个叛徒，应该就在他们之中。长老已经以“影灵兽有谕”为由让他们在主城集中了……你马上就能见到他们。"]],["感觉责任重大啊……"],[function():void
                        {
                           NpcDialog.show(400,"小赛尔",[[0,"我是要在这些人中找到叛徒吗？"]],["......"],[function():void
                           {
                              NpcDialog.show(3018,"伊万",[[0,"暗影氏族观望世间千年，我等自认为对这颗星球的历史有着相当客观的认识。旁观者清这句话，我族也再明白不过……我们需要参考你对这些“嫌疑人”做出的客观判断。"]],["（点击前往暗影氏族主城寻找弗雷德长老）"],[function():void
                              {
                                 SceneManager.changeScene(SceneType.COPY,80510);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
