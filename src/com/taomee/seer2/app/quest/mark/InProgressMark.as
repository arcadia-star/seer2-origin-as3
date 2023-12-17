package com.taomee.seer2.app.quest.mark
{
   import com.taomee.seer2.core.animation.FramePlayer;
   import com.taomee.seer2.core.animation.frame.FrameSequence;
   import com.taomee.seer2.core.entity.AnimateElement;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.utils.ByteArray;
   
   public class InProgressMark extends AnimateElement
   {
       
      
      private var _sequence:FrameSequence;
      
      private var _sequencePlayer:FramePlayer;
      
      public function InProgressMark()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._sequence = new FrameSequence();
         var _loc1_:ByteArray = UIManager.getByteArray("UI_QuestionMark");
         this._sequence.setData(_loc1_);
         this._sequence.isFromPool = false;
         this._sequencePlayer = new FramePlayer();
         this._sequencePlayer.frameSequence = this._sequence;
         this.animation = this._sequencePlayer;
         AnimateElementManager.addElement(this);
      }
   }
}
