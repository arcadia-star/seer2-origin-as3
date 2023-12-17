package com.taomee.seer2.app.processor.quest.handler.story.quest45
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_45_540 extends QuestMapHandler
   {
       
      
      private var tifflun:MovieClip;
      
      public function QuestMapHandler_45_540(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.showTiff();
         }
      }
      
      private function showTiff() : void
      {
         this.tifflun = _processor.resLib.getMovieClip("TiffMc");
         this.tifflun.tiff.addEventListener(MouseEvent.CLICK,this.tiffDia);
         (this.tifflun.tiff as MovieClip).buttonMode = true;
         var _loc1_:AcceptableMark = new AcceptableMark();
         _loc1_.x = 602;
         _loc1_.y = 277;
         _map.content.addChild(_loc1_);
         _map.content.addChild(this.tifflun);
      }
      
      private function tiffDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(114,"蒂芙伦",[[2,"哪里都可以，只有那里不行！"]],[" 发生什么事情了？"],[function():void
         {
            NpcDialog.show(32,"萨伦帝国小兵",[[0,"整个冰沁氏族我们都已经搜寻过了，除了神殿以外……所以，那个东西一定在神殿里面！！快，带我去！"]],[" 喂！你一个萨伦帝国的小杂兵居然那么嚣张！"],[function():void
            {
               NpcDialog.show(32,"萨伦帝国小兵",[[0,"哟，冰沁氏族的族人都没说什么，你是谁呀，那么多管闲事！"]],[" 我，呃，我是正义的使者！当然要多管闲事！"],[function():void
               {
                  NpcDialog.show(114,"蒂芙伦",[[2,"神殿是我们氏族最神圣的地方，然而那里却被下了诅咒。"]],[" 究竟是怎么回事儿呢？"],[function():void
                  {
                     MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("45_0"),2,[[1,0]],function():void
                     {
                        NpcDialog.show(114,"蒂芙伦",[[2,"打那以后，就没有人再来冰沁氏族观光了。大家都说，神殿被诅咒了，一定有冤魂寄居在王座上！"]],[" 我突然有点好奇……"],[function():void
                        {
                           NpcDialog.show(32,"萨伦帝国小兵",[[0,"王座……难道头儿要找的东西就在王座上？！我去找些人，你们在宫殿门口等我！"]],[" 为了搞清楚萨伦帝国的目的，我也去看看！"],[function():void
                           {
                              QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                              QuestManager.accept(_quest.id);
                           }]);
                        }]);
                     });
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            this.tifflun.tiff.removeEventListener(MouseEvent.CLICK,this.tiffDia);
            _map.content.removeChild(this.tifflun);
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,550);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.tifflun)
         {
            this.tifflun.tiff.removeEventListener(MouseEvent.CLICK,this.tiffDia);
            if(_map.content.contains(this.tifflun))
            {
               _map.content.removeChild(this.tifflun);
            }
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         super.processMapDispose();
      }
   }
}
