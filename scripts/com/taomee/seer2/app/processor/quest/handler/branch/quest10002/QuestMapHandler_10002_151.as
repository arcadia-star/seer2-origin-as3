package com.taomee.seer2.app.processor.quest.handler.branch.quest10002
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10002_151 extends BranchQuestMapHandler
   {
       
      
      private var _stoneClickCnt:int;
      
      private var _stoneVec:Vector.<MovieClip>;
      
      public function QuestMapHandler_10002_151(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         var _loc1_:XML = <npc id="403" resId="403" name="" dir="1" width="25" height="50" pos="450,300" actorPos="450,360" path="">
					<dialog npcId="403" npcName="奇鲁" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[呼~~~加油、加油！]]></node>
							<reply action="close"><![CDATA[这家伙好怪啊……]]></reply>
						</branch>
					</dialog>
				</npc>;
         initNpc(_loc1_);
         tip = "帮我把河里5颗石头弄走吧！";
         this.createInteractive();
      }
      
      private function createInteractive() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         if(QuestManager.isStepComplete(_questId,1))
         {
            return;
         }
         var _loc1_:Vector.<Point> = Vector.<Point>([new Point(120,164),new Point(272,204),new Point(170,330),new Point(190,400),new Point(403,367)]);
         this._stoneVec = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = _map.libManager.getMovieClip("UI_stone");
            _loc3_.gotoAndStop(1);
            _loc3_.addEventListener(MouseEvent.CLICK,this.onStoneClick);
            _loc3_.x = _loc1_[_loc2_].x;
            _loc3_.y = _loc1_[_loc2_].y;
            _loc3_.buttonMode = true;
            _map.ground.addChild(_loc3_);
            this._stoneVec.push(_loc3_);
            _loc2_++;
         }
         this._stoneClickCnt = 0;
      }
      
      private function onStoneClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(QuestManager.isAccepted(_questId))
         {
            _loc2_ = param1.target as MovieClip;
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onStoneClick);
            _loc2_.gotoAndPlay(2);
            ++this._stoneClickCnt;
            if(this._stoneClickCnt >= 5)
            {
               QuestManager.completeStep(_questId,1);
            }
         }
      }
      
      override protected function completeQuest() : void
      {
         DialogPanel.showForSimple(403,"奇鲁",[[0,"好啦？你的速度真快！我要更加努力了！谢谢，这个送给你。"]],"谢谢，再见！",this.onDialogOver);
      }
      
      private function onDialogOver() : void
      {
         QuestManager.completeStep(_questId,2);
      }
      
      private function clearStone() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._stoneVec.length)
         {
            _loc2_ = this._stoneVec[_loc1_];
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onStoneClick);
            _loc2_.stop();
            DisplayUtil.removeForParent(_loc2_);
            _loc1_++;
         }
         this._stoneVec = null;
      }
      
      override protected function clearQuest() : void
      {
         if(this._stoneVec)
         {
            this.clearStone();
         }
         super.clearQuest();
      }
   }
}
