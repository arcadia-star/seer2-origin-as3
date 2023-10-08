package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_1000 extends MapProcessor
   {
       
      
      private var petVec:Vector.<Sprite>;
      
      private var eyeFightId:Array;
      
      private var dayLimitId:Array;
      
      private var dayaLimitVec:Vector.<Parser_1065>;
      
      private var fightNum:Array;
      
      private var isFightPet:Boolean;
      
      private var isCanFight:Boolean;
      
      public function MapProcessor_1000(param1:MapModel)
      {
         this.eyeFightId = [208,206,207,209,210];
         this.dayLimitId = [539,537,538,540,541];
         this.fightNum = [1,1,1,1,3];
         super(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.petVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.toFight);
            _loc1_++;
         }
      }
      
      override public function init() : void
      {
         super.init();
         this.createNpc();
         this.dayaLimitVec = new Vector.<Parser_1065>();
         this.requestDayLimit();
         if(FightManager.isJustWinFight() && FightManager.currentFightRecord.initData.positionIndex == 210)
         {
            if(QuestManager.isStepComplete(10136,8) && !QuestManager.isComplete(10136))
            {
               QuestManager.completeStep(10136,9);
            }
         }
      }
      
      private function createNpc() : void
      {
         var _loc1_:Mobile = null;
         var _loc2_:Mobile = null;
         var _loc3_:Mobile = null;
         _loc1_ = new Mobile();
         _loc2_ = new Mobile();
         _loc3_ = new Mobile();
         var _loc4_:Mobile = new Mobile();
         _loc1_.resourceUrl = URLUtil.getActivityMobile("Pet57");
         _loc1_.x = 438;
         _loc1_.y = 338;
         _loc2_.resourceUrl = URLUtil.getActivityMobile("Pet252");
         _loc2_.x = 353;
         _loc2_.y = 360;
         _loc3_.resourceUrl = URLUtil.getActivityMobile("Pet205");
         _loc3_.x = 790;
         _loc3_.y = 392;
         _loc4_.resourceUrl = URLUtil.getActivityMobile("Pet24");
         _loc4_.x = 725;
         _loc4_.y = 345;
         MobileManager.addMobile(_loc1_,MobileType.NPC);
         MobileManager.addMobile(_loc2_,MobileType.NPC);
         MobileManager.addMobile(_loc3_,MobileType.NPC);
         MobileManager.addMobile(_loc4_,MobileType.NPC);
         _loc1_.buttonMode = true;
         _loc2_.buttonMode = true;
         _loc3_.buttonMode = true;
         _loc4_.buttonMode = true;
         this.petVec = new Vector.<Sprite>();
         this.petVec.push(_loc1_);
         this.petVec.push(_loc2_);
         this.petVec.push(_loc3_);
         this.petVec.push(_loc4_);
         this.petVec.push(_map.content["eyePet"]);
         MovieClip(this.petVec[4]).buttonMode = true;
         MovieClip(this.petVec[4]).gotoAndStop(2);
         this.petVec[4]["mc"].gotoAndStop(1);
         MovieClip(this.petVec[4]).gotoAndStop(1);
         this.petVec[4]["mc"].gotoAndStop(1);
         this.petVec[4].mouseChildren = false;
         _loc1_.mouseChildren = false;
         _loc2_.mouseChildren = false;
         _loc3_.mouseChildren = false;
         _loc4_.mouseChildren = false;
         this.initEvent();
      }
      
      private function requestDayLimit() : void
      {
         Connection.addCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.getLimit);
         var _loc1_:int = int(this.dayLimitId.length);
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUnsignedInt(_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_.writeUnsignedInt(this.dayLimitId[_loc3_]);
            _loc3_++;
         }
         Connection.send(CommandSet.GET_RANGE_DAY_LIMIT_1209,_loc2_);
      }
      
      private function getLimit(param1:MessageEvent) : void
      {
         var _loc5_:Parser_1065 = null;
         Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209,this.getLimit);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new Parser_1065(_loc2_);
            this.dayaLimitVec.push(_loc5_);
            _loc4_++;
         }
         this.checkFightPet();
         this.initEvent();
      }
      
      private function checkFightPet() : void
      {
         var _loc3_:Parser_1065 = null;
         var _loc4_:int = 0;
         var _loc5_:Parser_1065 = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.dayaLimitVec.length - 1)
         {
            _loc3_ = this.dayaLimitVec[_loc1_];
            _loc4_ = this.dayLimitId.indexOf(_loc3_.id);
            if(_loc3_.count >= this.fightNum[_loc4_])
            {
               this.petVec[_loc1_].visible = false;
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.dayaLimitVec.length - 1)
         {
            _loc5_ = this.dayaLimitVec[_loc2_];
            _loc6_ = this.dayLimitId.indexOf(_loc5_.id);
            this.isFightPet = true;
            if(_loc5_.count < this.fightNum[_loc6_])
            {
               this.isFightPet = false;
               break;
            }
            _loc2_++;
         }
         if(this.dayaLimitVec[4].count == this.dayLimitId[4])
         {
            if(FightManager.isJustWinFight() && (FightManager.currentFightRecord.initData.positionIndex == 209 || FightManager.currentFightRecord.initData.positionIndex == 208 || FightManager.currentFightRecord.initData.positionIndex == 207 || FightManager.currentFightRecord.initData.positionIndex == 206))
            {
               this.toForbid();
            }
         }
         if(this.isFightPet)
         {
            if(this.dayaLimitVec[4].count == 0)
            {
               this.toThaw();
            }
            else
            {
               MovieClip(this.petVec[4]).gotoAndStop(2);
               this.petVec[4]["mc"].gotoAndStop(1);
            }
         }
      }
      
      private function toThaw() : void
      {
         MovieClip(this.petVec[4]).gotoAndStop(1);
         this.petVec[4]["mc"].gotoAndStop(1);
         MovieClipUtil.playMc(this.petVec[4]["mc"],1,this.petVec[4]["mc"].totalFrames,function():void
         {
            MovieClip(petVec[4]).gotoAndStop(2);
            petVec[4]["mc"].gotoAndStop(1);
         });
      }
      
      private function toForbid() : void
      {
         MovieClip(this.petVec[4]).gotoAndStop(2);
         this.petVec[4]["mc"].gotoAndStop(1);
         MovieClipUtil.playMc(this.petVec[4]["mc"],1,this.petVec[4]["mc"].totalFrames,function():void
         {
            MovieClip(petVec[4]).gotoAndStop(1);
            petVec[4]["mc"].gotoAndStop(1);
         });
      }
      
      private function initEvent() : void
      {
         if(!QuestManager.isStepComplete(10136,8) && !QuestManager.isComplete(10136))
         {
            this.isCanFight = false;
         }
         else if(QuestManager.isStepComplete(10136,8) || QuestManager.isComplete(10136))
         {
            this.isCanFight = true;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.petVec[_loc1_].addEventListener(MouseEvent.CLICK,this.toFight);
            _loc1_++;
         }
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         if(!this.isCanFight)
         {
            AlertManager.showAlert("必须完成目灵兽试炼第三章的挑战精灵才可以和我们对战！！");
            return;
         }
         var _loc2_:Sprite = param1.target as Sprite;
         var _loc3_:int = this.petVec.indexOf(_loc2_);
         if(_loc3_ == 4)
         {
            if(this.isFightPet)
            {
               if(this.dayaLimitVec[4].count < this.fightNum[4])
               {
                  NpcDialog.show(406,"目灵兽",[[0,"我是王之双目，草目氏族的守护者目灵"]],["挑战目灵兽"],[this.fightEye]);
               }
               else
               {
                  NpcDialog.show(406,"目灵兽",[[0,"今天的挑战就到此为止，明天再来挑战我吧！"]],["好的"]);
               }
            }
            else
            {
               NpcDialog.show(406,"目灵兽",[[0,"想挑战我必须先打败前面的四只精灵来证明你的能力。每将守护精灵全部击败1次你将有3次挑战我的机会！"]],[" 好吧"]);
            }
         }
         else if(this.dayaLimitVec[_loc3_].count < this.fightNum[_loc3_])
         {
            FightManager.startFightWithWild(this.eyeFightId[_loc3_]);
         }
         else
         {
            NpcDialog.show(406,"目灵兽",[[0,"他今天居然输给你了，我今天是不会让他再和你对战了。避免丢人现眼..."]],["好的"]);
         }
      }
      
      private function fightEye() : void
      {
         FightManager.startFightWithWild(this.eyeFightId[4]);
      }
   }
}
