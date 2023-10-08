package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   
   public class MapProcessor_1900 extends MapProcessor
   {
      
      private static const current_wave_limit:int = 203207;
      
      private static const floor_forever_limit:int = 203205;
      
      private static const floor_waves:Array = [2,3,4,6,8,10];
      
      private static const current_wave_monster_limit:int = 203214;
      
      private static const current_monster_ids_limit:Array = [203208,203209,203210,203211,203212,203213];
      
      private static const Positions:Array = [new Point(290,280),new Point(179,293),new Point(214,452),new Point(438,472),new Point(778,217),new Point(812,400)];
      
      private static const ALL_MONSTERS:Array = [170,1003,386,238,439,378,1006,442,450,453,1046];
      
      private static const FIGHT_ID:Array = [598,599,600,601,602,603,604,605,606,607,608];
      
      private static const NPC_ID:Array = [509,455,631,506,632,563,603,630,619,620,514];
      
      private static const request_limit:Array = [203205,203207,current_wave_monster_limit,204497,203208,203209,203210,203211,203212,203213];
      
      private static const swap_id:int = 1909;
       
      
      private var floorTxt:TextField;
      
      private var tipMc:MovieClip;
      
      private var tips:MovieClip;
      
      private var currentWave:int = 0;
      
      private var currentFloor:int = 0;
      
      private var currentWaveMonster:int = 0;
      
      private var currentMonsterIds:Vector.<uint>;
      
      private var mobile_list:Array;
      
      private var next_time:int = 0;
      
      public function MapProcessor_1900(param1:MapModel)
      {
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
         this.tips = this.tipMc["tips"];
         this.tips.gotoAndStop(1);
         this.tipMc.visible = false;
         this.tipMc.mouseChildren = this.tipMc.mouseEnabled = false;
      }
      
      private function getSpecialItem(param1:ItemEvent) : void
      {
         var e:ItemEvent = param1;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getSpecialItem);
         if(ItemManager.getSpecialItem(603309))
         {
            AlertManager.showAlert("你已经通关了，赶紧神化月神吧",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,8502);
            });
         }
         else
         {
            this.requestLimit();
         }
      }
      
      private function requestData() : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getSpecialItem);
         ItemManager.requestSpecialItemList();
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
            currentWave = par.infoVec[1];
            currentWaveMonster = par.infoVec[2];
            next_time = par.infoVec[3];
            currentMonsterIds = par.infoVec.slice(4,par.infoVec.length);
            if(next_time > TimeManager.getServerTime())
            {
               AlertManager.showAlert("成功清除暗黑兵团！月神需要安心修炼一段时间！（时间到后可进入下一层修炼）",function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,8502);
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
               this.tips.gotoAndStop(1);
               TweenLite.to(this.tipMc,2,{"alpha":0});
            }
            else
            {
               this.tipMc.visible = true;
               this.tipMc.alpha = 1;
               this.tips.gotoAndStop(2);
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
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.getSpecialItem);
      }
   }
}
