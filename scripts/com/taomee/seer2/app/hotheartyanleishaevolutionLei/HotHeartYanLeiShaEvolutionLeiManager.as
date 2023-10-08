package com.taomee.seer2.app.hotheartyanleishaevolutionLei
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HotHeartYanLeiShaEvolutionLeiManager
   {
      
      private static var _npc630:Mobile;
      
      private static var _npcBOSS:Mobile;
      
      private static var fight630ID:int = 1577;
      
      private static var fightBOSSID:int = 1578;
      
      private static var _curIdx:int;
      
      private static var BUY_COUNT_630:int = 605721;
      
      private static var BUY_COUNT_BOSS:int = 605722;
      
      private static const DAY_LIST:Array = [5057,5063];
      
      private static const FOR_LIST:Array = [250115,250117];
      
      private static var gameCount630:int;
      
      private static var gameCountBOSS:int;
      
      private static var buyCount630:int;
      
      private static var buyCountBOSS:int;
       
      
      public function HotHeartYanLeiShaEvolutionLeiManager()
      {
         super();
      }
      
      public static function setup(param1:int, param2:Boolean = true) : void
      {
         var idx:int = param1;
         var createFlag:Boolean = param2;
         _curIdx = idx;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            buyCount630 = par.infoVec[0];
            buyCountBOSS = par.infoVec[1];
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               gameCount630 = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[0]),buyCount630,3);
               gameCountBOSS = ActsHelperUtil.getCanNum(param1.getCount(DAY_LIST[1]),buyCountBOSS,1);
               if(createFlag = true)
               {
                  if(idx == 1)
                  {
                     createNPC630();
                  }
                  else if(idx == 2)
                  {
                     createNPCBOSS();
                  }
               }
            });
         });
      }
      
      private static function createNPCBOSS() : void
      {
         _npcBOSS = new Mobile();
         _npcBOSS.setPostion(new Point(640,380));
         _npcBOSS.resourceUrl = URLUtil.getNpcSwf(895);
         _npcBOSS.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npcBOSS.label = "冥·雷煞";
         _npcBOSS.buttonMode = true;
         MobileManager.addMobile(_npcBOSS,MobileType.NPC);
         _npcBOSS.addEventListener(MouseEvent.CLICK,onBOSSClick);
      }
      
      private static function onBOSSClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(gameCountBOSS <= 0)
         {
            ShopManager.buyItemForId(BUY_COUNT_BOSS,function(param1:*):void
            {
               setup(_curIdx,false);
            });
         }
         else
         {
            FightManager.startFightWithWild(fightBOSSID);
         }
      }
      
      private static function createNPC630() : void
      {
         _npc630 = new Mobile();
         _npc630.setPostion(new Point(640,380));
         _npc630.resourceUrl = URLUtil.getNpcSwf(692);
         _npc630.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npc630.label = "雷煞";
         _npc630.buttonMode = true;
         MobileManager.addMobile(_npc630,MobileType.NPC);
         _npc630.addEventListener(MouseEvent.CLICK,onNpcClick);
      }
      
      private static function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(gameCount630 <= 0)
         {
            ShopManager.buyItemForId(BUY_COUNT_630,function(param1:*):void
            {
               setup(_curIdx,false);
            });
         }
         else
         {
            FightManager.startFightWithWild(fight630ID);
         }
      }
      
      public static function dispose() : void
      {
         if(_npc630)
         {
            _npc630.removeEventListener(MouseEvent.CLICK,onNpcClick);
            MobileManager.removeMobile(_npc630,MobileType.NPC);
            _npc630 = null;
         }
         if(_npcBOSS)
         {
            _npcBOSS.removeEventListener(MouseEvent.CLICK,onBOSSClick);
            MobileManager.removeMobile(_npcBOSS,MobileType.NPC);
            _npcBOSS = null;
         }
      }
   }
}
