package com.taomee.seer2.app.processor.quest.handler.story.quest45
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_45_550 extends QuestMapHandler
   {
       
      
      private var tifflun:MovieClip;
      
      private var threeArms:MovieClip;
      
      public function QuestMapHandler_45_550(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         this.tifflun = _processor.resLib.getMovieClip("Tiff");
         this.tifflun.buttonMode = true;
         this.tifflun.addEventListener(MouseEvent.CLICK,this.tiffDia);
         _map.content.addChild(this.tifflun);
      }
      
      private function tiffDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(114,"蒂芙伦",[[0,"不行……我不能再往里走了……太可怕了……"]],[" 趁那个小兵还没有来，我有些问题要问你。"],[function():void
         {
            NpcDialog.show(400,"我",[[0,"冰沁氏族究竟怎么了？萨伦帝国的人那么横行霸道，你为什么对他们惟命是从？"]],[" 其他的族人们都去哪儿了？"],[function():void
            {
               NpcDialog.show(114,"蒂芙伦",[[2,"这个说来话长……据说很久以前……"]],[" 然后呢？"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("45_0"),function():void
                  {
                     NpcDialog.show(114,"蒂芙伦",[[2,"自那以后，冰沁氏族没有了守护者，只能任由萨伦帝国的人欺凌！不过，他们一直在寻找冰后的下落，却没有任何头绪。"]],[" 这当中似乎有很多疑点啊……"],[function():void
                     {
                        threeArms = _processor.resLib.getMovieClip("ThreeArms");
                        _map.front.addChild(threeArms);
                        MovieClipUtil.playMc(threeArms,1,threeArms.totalFrames,function():void
                        {
                           _map.front.removeChild(threeArms);
                           threeArms = null;
                           tifflun.removeEventListener(MouseEvent.CLICK,tiffDia);
                           _map.content.removeChild(tifflun);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,stepComplete);
                           QuestManager.completeStep(_quest.id,1);
                        },true);
                     }]);
                  },true,false,2);
               }]);
            }]);
         }]);
      }
      
      private function stepComplete(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.stepComplete);
            SceneManager.changeScene(SceneType.LOBBY,590,630,360);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.stepComplete);
         if(this.threeArms)
         {
            if(_map.front.contains(this.threeArms))
            {
               _map.front.removeChild(this.threeArms);
            }
            this.threeArms = null;
         }
         if(this.tifflun)
         {
            this.tifflun.removeEventListener(MouseEvent.CLICK,this.tiffDia);
            if(_map.content.contains(this.tifflun))
            {
               _map.content.removeChild(this.tifflun);
            }
            this.tifflun = null;
         }
         super.processMapDispose();
      }
   }
}
