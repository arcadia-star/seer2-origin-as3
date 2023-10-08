package com.taomee.seer2.app.processor.quest.handler.story.quest20
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.DisplayUtil;
   
   public class FightQuest20 extends EventDispatcher
   {
      
      public static var SELECT_COMPLETE:String = "selectComplete";
      
      private static var _mc:MovieClip;
      
      private static var _petList:Vector.<MovieClip>;
      
      private static var _thisPetList:Vector.<MovieClip>;
      
      private static var _ok:SimpleButton;
      
      private static var _closeBtn:SimpleButton;
      
      private static var _selectList:Vector.<int>;
      
      private static var _nameTxt:TextField;
      
      private static var _closeFun:Function;
       
      
      public function FightQuest20()
      {
         super();
      }
      
      public static function setup(param1:MovieClip, param2:Function) : void
      {
         _mc = param1;
         _closeFun = param2;
         LayerManager.topLayer.addChild(_mc);
         init();
      }
      
      private static function init() : void
      {
         _petList = Vector.<MovieClip>([]);
         _thisPetList = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _petList.push(_mc["pet" + _loc1_]);
            _thisPetList.push(_mc["thisPet" + _loc1_]);
            _loc1_++;
         }
         _ok = _mc["ok"];
         _closeBtn = _mc["closeBtn"];
         _ok.alpha = 0.4;
         _ok.mouseEnabled = false;
         _nameTxt = _mc["nameTxT"];
         _nameTxt.text = ActorManager.actorInfo.nick;
         _selectList = Vector.<int>([]);
         initEvent();
      }
      
      private static function initEvent() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in _petList)
         {
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,onPetClick);
         }
         _ok.addEventListener(MouseEvent.CLICK,onOK);
         _closeBtn.addEventListener(MouseEvent.CLICK,onClose);
      }
      
      private static function onPetClick(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = _petList.indexOf(_loc2_);
         var _loc4_:MovieClip;
         if((_loc4_ = _thisPetList[_loc3_]).currentFrame == 1)
         {
            _loc4_.gotoAndStop(2);
            _selectList.push(_loc3_ + 1);
         }
         else
         {
            _loc5_ = _selectList.indexOf(_loc3_ + 1);
            _loc4_.gotoAndStop(1);
            _selectList.splice(_loc5_,1);
         }
         if(_selectList.length == 3)
         {
            _ok.alpha = 1;
            _ok.mouseEnabled = true;
         }
         else
         {
            _ok.alpha = 0.4;
            _ok.mouseEnabled = false;
         }
      }
      
      private static function removeEvent() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in _petList)
         {
            _loc1_.buttonMode = false;
            _loc1_.removeEventListener(MouseEvent.CLICK,onPetClick);
         }
         _ok.removeEventListener(MouseEvent.CLICK,onOK);
         _closeBtn.removeEventListener(MouseEvent.CLICK,onClose);
      }
      
      private static function onClose(param1:MouseEvent) : void
      {
         clear();
         if(_closeFun != null)
         {
            _closeFun();
            _closeFun = null;
         }
      }
      
      private static function onOK(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         clear();
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         for each(_loc3_ in _selectList)
         {
            _loc2_.writeInt(_loc3_);
         }
         QuestMapHandler_20_550.flghtIndex = 4;
         FightManager.startFightWithNPC(4,3,_loc2_);
         _selectList = null;
      }
      
      private static function clear() : void
      {
         removeEvent();
         _petList = null;
         _thisPetList = null;
         _ok = null;
         DisplayUtil.removeForParent(_mc);
         _mc = null;
      }
   }
}
