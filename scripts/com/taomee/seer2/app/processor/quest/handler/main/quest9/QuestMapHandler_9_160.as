package com.taomee.seer2.app.processor.quest.handler.main.quest9
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class QuestMapHandler_9_160 extends QuestMapHandler
   {
       
      
      private var _stepAnimation:MovieClip;
      
      private var _ballMc:MovieClip;
      
      public function QuestMapHandler_9_160(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._stepAnimation = _map.front["quest_9"];
         if(Boolean(_quest.isStepCompete(1)) && !_quest.isStepCompete(2))
         {
            _processor.showMouseHintAt(210,300);
         }
         if(Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4))
         {
            _processor.showMouseHintAt(940,411);
         }
         if(Boolean(_quest.isStepCompete(5)) && !_quest.isStepCompete(6))
         {
            this.processStep6();
         }
         if(Boolean(_quest.isStepCompete(6)) && !_quest.isStepCompete(7))
         {
            this.processStep7();
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
      
      private function processStep6() : void
      {
         MovieClipUtil.getChildList(this._stepAnimation,2,[0],function(param1:Vector.<DisplayObject>):void
         {
            var mc:MovieClip;
            var children:Vector.<DisplayObject> = param1;
            ActorManager.getActor().x = 580;
            ActorManager.getActor().y = 455;
            mc = children[0] as MovieClip;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               MovieClipUtil.getChildList(_stepAnimation,3,[0],function(param1:Vector.<DisplayObject>):void
               {
                  var mc:MovieClip = null;
                  var children:Vector.<DisplayObject> = param1;
                  MobileManager.getMobile(23,MobileType.NPC).visible = false;
                  MobileManager.getMobile(24,MobileType.NPC).visible = false;
                  mc = children[0] as MovieClip;
                  MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
                  {
                     var point:Point;
                     _ballMc = mc["ball"] as MovieClip;
                     point = _ballMc.localToGlobal(new Point(0,0));
                     _ballMc.x = point.x;
                     _ballMc.y = point.y;
                     _map.front.addChild(_ballMc);
                     NpcDialog.show(23,"神谕祭司",[[0,"离开这里！快！这场浩劫本不应该牵连到你！快走吧！"]],[" 为什么我不能动了！祭祀！"],[function():void
                     {
                        MovieClipUtil.getChildList(_stepAnimation,4,[0],function(param1:Vector.<DisplayObject>):void
                        {
                           var children:Vector.<DisplayObject> = param1;
                           var mc:* = children[0] as MovieClip;
                           MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
                           {
                              NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"洛水口中的它是谁?不管了！快追！！！"]],["洛水往深水之城方向走的"],[function():void
                              {
                                 DisplayObjectUtil.removeFromParent(_stepAnimation);
                                 DisplayObjectUtil.removeFromParent(_ballMc);
                                 QuestManager.completeStep(_quest.id,6);
                                 processStep7();
                              }]);
                           },true);
                        });
                     }]);
                  },true);
               });
            },true);
         });
      }
      
      private function processStep7() : void
      {
         _processor.showMouseHintAt(-90,460);
      }
   }
}
