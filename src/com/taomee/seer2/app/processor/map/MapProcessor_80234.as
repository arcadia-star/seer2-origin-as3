package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80234 extends MapProcessor
   {
      
      private static const current_wave_limit:int = 204498;
      
      private static const floor_forever_limit:int = 204496;
      
      private static const floor_waves:Array = [1,3,4,6,8,10];
      
      private static const current_wave_monster_limit:int = 204505;
      
      private static const current_monster_ids_limit:Array = [204499,204500,204501,204502,204503,204504];
      
      private static const Positions:Array = [new Point(230,350),new Point(260,293),new Point(214,452),new Point(438,472),new Point(708,273),new Point(712,400)];
      
      private static const ALL_MONSTERS:Array = [170,1003,386,238,439,378,1006,524,758,735,738];
      
      private static const FIGHT_ID:Array = [1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128];
      
      private static const NPC_ID:Array = [509,455,628,506,629,563,603,629,769,762,764];
      
      private static const request_limit:Array = [204496,204498,current_wave_monster_limit,204497,204499,204500,204501,204502,204503,204504];
      
      private static const swap_id:int = 3025;
       
      
      private var floorTxt:TextField;
      
      private var tipMc:MovieClip;
      
      private var oneKeyPass:SimpleButton;
      
      private var goodsBtn:SimpleButton;
      
      private var currentWave:int = 0;
      
      private var currentFloor:int = 0;
      
      private var currentWaveMonster:int = 0;
      
      private var currentMonsterIds:Vector.<uint>;
      
      private var mobile_list:Array;
      
      private var next_time:int = 0;
      
      private var butIDarr:Array;
      
      public function MapProcessor_80234(param1:MapModel)
      {
         this.butIDarr = [604048,604049,604050,604051,604052,604063];
         super(param1);
      }
      
      override public function init() : void
      {
         this.initMc();
         this.requestData();
      }
      
      private function initMc() : void
      {
         this.floorTxt = _map.content["floorTxt"];
         this.tipMc = _map.content["tipMc"];
         this.oneKeyPass = _map.content["oneKeyPass"];
         this.goodsBtn = _map.content["goodsBtn"];
         this.tipMc.mouseChildren = this.tipMc.mouseEnabled = false;
         this.goodsBtn.addEventListener(MouseEvent.CLICK,this.onClick);
         this.oneKeyPass.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = null;
         if(param1.currentTarget == this.goodsBtn)
         {
            ModuleManager.showAppModule("MedicineShopPanel");
         }
         else if(param1.currentTarget == this.oneKeyPass)
         {
            _loc2_ = new BuyPropInfo();
            _loc2_.itemId = this.butIDarr[this.currentFloor];
            _loc2_.buyComplete = this.buyComplete;
            ShopManager.buyVirtualItem(_loc2_);
         }
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         var par:Parser_1224 = param1;
         this.requestData();
         ActiveCountManager.requestActiveCountList(request_limit,function(param1:Parser_1142):void
         {
            currentFloor = param1.infoVec[0];
            if(currentFloor == 6)
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
               SceneManager.changeScene(SceneType.LOBBY,70);
            }
            else
            {
               SceneManager.changeScene(SceneType.COPY,80233);
            }
         });
      }
      
      private function requestData() : void
      {
         this.requestLimit();
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         ModuleManager.showAppModule("DaoMengKongJianPanel");
      }
      
      private function requestLimit() : void
      {
         ActiveCountManager.requestActiveCountList(request_limit,function(param1:Parser_1142):void
         {
            var b:Boolean;
            var i:int;
            var par:Parser_1142 = param1;
            currentFloor = par.infoVec[0];
            floorTxt.text = String(currentFloor + 1);
            if(currentFloor == 6)
            {
               SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
               SceneManager.changeScene(SceneType.LOBBY,70);
               return;
            }
            currentWave = par.infoVec[1];
            currentWaveMonster = par.infoVec[2];
            next_time = par.infoVec[3];
            currentMonsterIds = par.infoVec.slice(4,par.infoVec.length);
            if(next_time > TimeManager.getServerTime())
            {
               AlertManager.showAlert("成功清除！梦神需要安心修炼一段时间！（时间到后可进入下一层修炼）",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,80233);
               });
               return;
            }
            b = true;
            i = 0;
            while(i < currentMonsterIds.length)
            {
               if(currentMonsterIds[i] != 0)
               {
                  b = false;
                  break;
               }
               i++;
            }
            if(b)
            {
               SwapManager.swapItem(swap_id,1,function(param1:IDataInput):void
               {
                  requestData();
               });
               return;
            }
            updateDisplay();
         });
      }
      
      private function updateDisplay() : void
      {
         this.updateTips();
         this.updateMonsters();
      }
      
      private function updateTips() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.currentMonsterIds.length)
         {
            if(this.currentMonsterIds[_loc2_] != 0)
            {
               _loc1_ += 1;
            }
            _loc2_++;
         }
         if(this.currentWaveMonster == _loc1_)
         {
            if(this.currentWaveMonster > 1)
            {
               this.tipMc.visible = true;
               this.tipMc.alpha = 1;
               TweenLite.to(this.tipMc,2,{"alpha":0});
            }
            else
            {
               this.tipMc.visible = true;
               this.tipMc.alpha = 1;
               TweenLite.to(this.tipMc,2,{"alpha":0});
            }
         }
      }
      
      private function updateMonsters() : void
      {
         this.mobile_list = [];
         var _loc1_:int = 0;
         while(_loc1_ < this.currentMonsterIds.length)
         {
            this.mobile_list.push(new Mobile());
            if(this.currentMonsterIds[_loc1_] != 0)
            {
               this.mobile_list[_loc1_].resourceUrl = URLUtil.getNpcSwf(NPC_ID[ALL_MONSTERS.indexOf(this.currentMonsterIds[_loc1_])]);
               this.mobile_list[_loc1_].buttonMode = true;
               this.mobile_list[_loc1_].addEventListener(MouseEvent.CLICK,this.toFight);
               this.mobile_list[_loc1_].setPostion(Positions[_loc1_]);
               MobileManager.addMobile(this.mobile_list[_loc1_],MobileType.NPC);
            }
            _loc1_++;
         }
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var _loc2_:int = this.mobile_list.indexOf(param1.currentTarget as Mobile);
         var _loc3_:int = int(this.currentMonsterIds[_loc2_]);
         var _loc4_:int = ALL_MONSTERS.indexOf(_loc3_);
         var _loc5_:int = int(FIGHT_ID[_loc4_]);
         FightManager.startFightWithWild(_loc5_);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         this.currentWave = 0;
         this.currentWaveMonster = 0;
         this.currentMonsterIds = null;
         if(Boolean(this.mobile_list) && this.mobile_list.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.mobile_list.length)
            {
               (this.mobile_list[_loc1_] as Mobile).removeEventListener(MouseEvent.CLICK,this.toFight);
               MobileManager.removeMobile(this.mobile_list[_loc1_],MobileType.NPC);
               _loc1_++;
            }
            this.mobile_list = null;
         }
         if(this.tipMc)
         {
            TweenLite.killTweensOf(this.tipMc);
         }
         this.goodsBtn.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.oneKeyPass.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
   }
}
