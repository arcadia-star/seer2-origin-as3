package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
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
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_292 extends MapProcessor
   {
       
      
      private const PET_NUM:int = 5;
      
      private const dayLimitIDs:Array = [636,637,638,639,640];
      
      private const maxNums:Array = [1,1,1,1,3];
      
      private var mobile_arr:Vector.<Mobile>;
      
      private var dayLimitValues:Array;
      
      private var npcIDs:Array;
      
      private var fights:Array;
      
      private var mobilePostions:Array;
      
      public function MapProcessor_292(param1:MapModel)
      {
         this.dayLimitValues = [0,0,0,0,0];
         this.npcIDs = [557,558,559,560,561];
         this.fights = [352,353,354,355,356];
         this.mobilePostions = [new Point(285,285),new Point(370,370),new Point(620,370),new Point(800,235),new Point(500,320)];
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.mobile_arr = new Vector.<Mobile>();
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUnsignedInt(this.PET_NUM);
         var _loc2_:int = 0;
         while(_loc2_ < this.PET_NUM)
         {
            _loc1_.writeUnsignedInt(this.dayLimitIDs[_loc2_]);
            this.mobile_arr.push(new Mobile());
            _loc2_++;
         }
         DayLimitListManager.getDoCount(_loc1_,this.getDaylimit);
      }
      
      private function getDaylimit(param1:DayLimitListInfo) : void
      {
         var _loc2_:Parser_1065 = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.PET_NUM)
         {
            _loc2_ = param1.dayLimitList[_loc3_];
            _loc4_ = this.dayLimitIDs.indexOf(_loc2_.id);
            this.dayLimitValues[_loc4_] = _loc2_.count;
            _loc3_++;
         }
         this.checkMobile();
      }
      
      private function checkMobile() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.PET_NUM - 1)
         {
            if(this.dayLimitValues[_loc2_] < this.maxNums[_loc2_])
            {
               this.mobile_arr[_loc2_].resourceUrl = URLUtil.getNpcSwf(this.npcIDs[_loc2_]);
               this.mobile_arr[_loc2_].buttonMode = true;
               this.mobile_arr[_loc2_].addEventListener(MouseEvent.CLICK,this.toFight);
               this.mobile_arr[_loc2_].setPostion(this.mobilePostions[_loc2_]);
               this.mobile_arr[_loc2_].height = 100;
               if(_loc2_ > 1)
               {
                  this.mobile_arr[_loc2_].direction = 2;
               }
               MobileManager.addMobile(this.mobile_arr[_loc2_],MobileType.NPC);
               _loc1_ = false;
            }
            _loc2_++;
         }
         if(!_loc1_)
         {
            this.npcIDs[4] = 562;
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA && this.fights.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            if(FightManager.currentFightRecord.initData.positionIndex != 356)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ShowHuanPet"));
            }
         }
         this.mobile_arr[4].resourceUrl = URLUtil.getNpcSwf(this.npcIDs[4]);
         this.mobile_arr[4].buttonMode = true;
         this.mobile_arr[4].addEventListener(MouseEvent.CLICK,this.toFight);
         this.mobile_arr[4].setPostion(this.mobilePostions[4]);
         MobileManager.addMobile(this.mobile_arr[4],MobileType.NPC);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var index:int = 0;
         var event:MouseEvent = param1;
//         if(!QuestManager.isComplete(10177))
//         {
//            AlertManager.showAlert("你还没有完成幻灵兽试炼第三章的任务，不能挑战我!");
//            return;
//         }
         index = this.mobile_arr.indexOf(event.target as Mobile);
         if(index != 4)
         {
            FightManager.startFightWithWild(this.fights[index]);
         }
         else if(this.npcIDs[4] == 562)
         {
            NpcDialog.show(561,"幻灵兽",[[0,"只有将我身边的4只精灵击败时，你才是一个拥有激情与荣耀的勇士，我便承诺与你相见。你每天可以与我战斗3次。"]],[" 好吧"]);
         }
         else if(this.dayLimitValues[4] < this.maxNums[4])
         {
            NpcDialog.show(561,"幻灵兽",[[0,"深藏壶中多年，我应该重新拾回属于我的那份激情与荣耀了。是你，勇士，你让我重新找回自己。你每天可以与我战斗3次。"]],["  挑战幻灵兽","我准备下"],[function():void
            {
               FightManager.startFightWithWild(fights[index]);
            }]);
         }
         else
         {
            NpcDialog.show(561,"幻灵兽",[[0,"我想今日我已经完成了我的荣耀之战，请明天再来和我挑战吧。"]],[" 好吧"]);
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.PET_NUM)
         {
            this.mobile_arr[_loc1_].removeEventListener(MouseEvent.CLICK,this.toFight);
            _loc1_++;
         }
         super.dispose();
      }
   }
}
