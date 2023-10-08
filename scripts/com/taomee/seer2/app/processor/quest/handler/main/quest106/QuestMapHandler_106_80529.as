package com.taomee.seer2.app.processor.quest.handler.main.quest106
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_106_80529 extends QuestMapHandler
   {
       
      
      public function QuestMapHandler_106_80529(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         if(!QuestManager.isAccepted(_quest.id))
         {
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = _processor.resLib.getMovieClip("duoLuo");
         _loc1_.x -= 110;
         _loc1_.y += 44;
         SceneManager.active.mapModel.front.addChild(_loc1_);
         _loc1_.buttonMode = true;
         _loc1_.mouseChildren = false;
         this.onClick();
      }
      
      protected function onClick() : void
      {
         var dialog:Array = [[400,"小赛尔",[[0,"就是这里了，当年，就在这里，我用七块璞玉打开了通往能源之潮的道路，萨兰古尔之剑劈开天空，七色的光芒将未来和希望迎接到我的面前……现在我回来了，带着疑惑但是不曾迷茫。"]],["......"]],[10,"巴蒂",[[0,"那么，能源之潮，别来无恙。"]],["......"]],[11,"多罗",[[0,"我还记得……那里是个很厉害的地方啊！"]],["........"]],[400,"小赛尔",[[0,"那么我们走吧！去我们的过去，去我们的未来！"]],["......"]]];
         NpcDialog.showDialogs(dialog,function():void
         {
            var _loc1_:MovieClip = null;
            _loc1_ = _processor.resLib.getMovieClip("qq_2");
            _loc1_.x += 135;
            _loc1_.y += 247;
            SceneManager.active.mapModel.front.addChild(_loc1_);
            _loc1_.buttonMode = true;
            _loc1_.mouseChildren = false;
            _loc1_.addEventListener(MouseEvent.CLICK,onClick1);
         });
      }
      
      protected function onClick1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("52_0"),function():void
         {
            QuestManager.completeStep(_quest.id,1);
            SceneManager.changeScene(SceneType.COPY,80530);
         },true,false,2);
      }
   }
}
