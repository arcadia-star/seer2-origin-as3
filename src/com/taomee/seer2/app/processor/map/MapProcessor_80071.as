package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80071 extends MapProcessor
   {
      
      private static const PET_KILL_DAY:int = 867;
      
      private static const BOSS_FIGHT_DAY:int = 868;
      
      private static const USE_FREE_HURT_ITEM_FOR:uint = 203405;
      
      private static const MI_BUY_FIGHT_NUM_FOR:uint = 203406;
      
      private static const IS_USE_HURT_FOR:uint = 203407;
      
      private static const USE_KILL_PET_SWAP:int = 2145;
      
      private static const USE_HURT_SWAP:int = 2146;
      
      private static const FIGHT_PET_INDEX:int = 691;
      
      private static const FIGHT_BOSS_INDEX:int = 692;
      
      private static const MI_BUY_LIST:Vector.<uint> = Vector.<uint>([603361,500597]);
      
      private static const ITEM_ID:uint = 500597;
      
      private static const PET_POS:Array = [[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400],[200,400]];
      
      private static const BOSS_POS:Vector.<int> = Vector.<int>([200,400]);
      
      private static var _isFightPet:Boolean;
       
      
      private var _resLib:ApplicationDomain;
      
      private var _npc:Mobile;
      
      private var _activityMonsterVec:Vector.<SpawnedPet>;
      
      private var _openList:Vector.<SimpleButton>;
      
      private var _fightNum:int;
      
      public function MapProcessor_80071(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.ziDianSuperProcessInit();
      }
      
      private function ziDianSuperProcessInit() : void
      {
         this.hideLobbyMenu();
         this.getURL();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("ziDianSuperProcess/ZiDianSceneMC"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            initSet();
            createOpenMenu();
         });
      }
      
      private function initSet() : void
      {
         DayLimitManager.getDoCount(PET_KILL_DAY,function(param1:int):void
         {
            var petNum:int = 0;
            var val:int = param1;
            if(val < 12)
            {
               petNum = 12 - val;
               if(!_isFightPet)
               {
                  MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ziDianSuperProcess/PetShow"),function():void
                  {
                     _isFightPet = true;
                     ModuleManager.showModule(URLUtil.getAppModule("KillMonsterPanel"),"正在打开消灭十二重甲面板...",{"func":useKillPet});
                     createPetList(petNum);
                  },true,true,2,true);
               }
               else
               {
                  createPetList(petNum);
               }
            }
            else
            {
               DayLimitManager.getDoCount(BOSS_FIGHT_DAY,function(param1:int):void
               {
                  var _scenMc:MovieClip = null;
                  var val:int = param1;
                  if(val == 0)
                  {
                     _scenMc = getMovie("SceneMC");
                     _scenMc.x = -452;
                     _scenMc.y = -68;
                     _map.front.addChild(_scenMc);
                     MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_scenMc);
                        _scenMc = null;
                        createNpc();
                     },true);
                  }
                  else
                  {
                     createNpc();
                  }
               });
            }
         });
      }
      
      private function createOpenMenu() : void
      {
         this._openList = new Vector.<SimpleButton>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._openList.push(_map.content["open" + _loc1_]);
            this._openList[_loc1_].addEventListener(MouseEvent.CLICK,this.onOpen);
            _loc1_++;
         }
      }
      
      private function onOpen(param1:MouseEvent) : void
      {
         var _loc2_:int = this._openList.indexOf(param1.currentTarget as SimpleButton);
         switch(_loc2_)
         {
            case 0:
               if(this._activityMonsterVec == null || this._activityMonsterVec && this._activityMonsterVec.length == 0)
               {
                  AlertManager.showAlert("甲虫已经没有了，不需要使用一键清除了哦!");
               }
               else
               {
                  ModuleManager.showModule(URLUtil.getAppModule("KillMonsterPanel"),"正在打开消灭十二重甲面板...",{"func":this.useKillPet});
               }
               break;
            case 1:
               ModuleManager.showModule(URLUtil.getAppModule("MedicineShopPanel"),"正在打开战斗药剂面板...");
               break;
            case 2:
               this.hurtItemBuyHandle();
         }
      }
      
      private function hurtItemBuyHandle() : void
      {
         ActiveCountManager.requestActiveCount(USE_FREE_HURT_ITEM_FOR,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var val:uint = param2;
            if(val == 0)
            {
               SwapManager.swapItem(USE_HURT_SWAP,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  AlertManager.showAlert("免费使用成功，赶快去挑战紫煞吧!");
               });
            }
            else
            {
               ActiveCountManager.requestActiveCount(IS_USE_HURT_FOR,function(param1:uint, param2:uint):void
               {
                  var type:uint = param1;
                  var val:uint = param2;
                  if(val == 1)
                  {
                     AlertManager.showAlert("你已经是战斗加成效果了，使用完了再买吧!");
                  }
                  else
                  {
                     ItemManager.requestItemList(function():void
                     {
                        if(ItemManager.getItemQuantityByReferenceId(ITEM_ID) > 0)
                        {
                           SwapManager.swapItem(USE_HURT_SWAP,1,function(param1:IDataInput):void
                           {
                              new SwapInfo(param1);
                           });
                        }
                        else
                        {
                           buyHandle(MI_BUY_LIST[1],false,false);
                        }
                     });
                  }
               });
            }
         });
      }
      
      private function buyHandle(param1:uint, param2:Boolean = false, param3:Boolean = true) : void
      {
         ModuleManager.addEventListener("BuyPropPanel",ModuleEvent.DISPOSE,this.onBuyPanelHide);
         ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"),"正在打开米币小面板...",{
            "itemId":param1,
            "canBatch":param2,
            "islimitNum":param3,
            "buyType":"mi",
            "itemType":"hideShop"
         });
      }
      
      private function onBuyPanelHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("BuyPropPanel",ModuleEvent.DISPOSE,this.onBuyPanelHide);
      }
      
      private function clearOpenMenu() : void
      {
         var _loc1_:int = 0;
         if(this._openList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._openList.length)
            {
               this._openList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onOpen);
               _loc1_++;
            }
            this._openList = null;
         }
      }
      
      private function createPetList(param1:int) : void
      {
         var _loc3_:SpawnedPet = null;
         this.clearPetList();
         this._activityMonsterVec = new Vector.<SpawnedPet>();
         var _loc2_:uint = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new SpawnedPet(148,FIGHT_PET_INDEX,0);
            this._activityMonsterVec.push(_loc3_);
            MobileManager.addMobile(_loc3_,MobileType.SPAWNED_PET);
            _loc2_++;
         }
      }
      
      private function clearPetList() : void
      {
         var _loc1_:int = 0;
         if(this._activityMonsterVec)
         {
            _loc1_ = 0;
            while(_loc1_ < this._activityMonsterVec.length)
            {
               if(this._activityMonsterVec[_loc1_])
               {
                  MobileManager.removeMobile(this._activityMonsterVec[_loc1_],MobileType.SPAWNED_PET);
               }
               _loc1_++;
            }
         }
         this._activityMonsterVec = null;
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function useKillPet() : void
      {
         this.clearPetList();
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ziDianSuperProcess/PetAllSkilled"),function():void
         {
            var _scenMc:MovieClip = null;
            _scenMc = getMovie("SceneMC");
            _scenMc.x = -452;
            _scenMc.y = -68;
            _map.front.addChild(_scenMc);
            MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scenMc);
               _scenMc = null;
               createNpc();
            },true);
         },true,true,2,true);
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(460,275));
            this._npc.resourceUrl = URLUtil.getNpcSwf(648);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "紫煞";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("BossFightPanel"),"正在打开紫电挑战面板...",{"func":this.startFight});
      }
      
      private function startFight() : void
      {
         DayLimitManager.getDoCount(BOSS_FIGHT_DAY,function(param1:int):void
         {
            var val:int = param1;
            ActiveCountManager.requestActiveCount(MI_BUY_FIGHT_NUM_FOR,function(param1:uint, param2:uint):void
            {
               var type:uint = param1;
               var count:uint = param2;
               if(VipManager.vipInfo.isVip())
               {
                  if(6 - val >= 0)
                  {
                     _fightNum = 6 - val + count;
                  }
                  else
                  {
                     _fightNum = count;
                  }
               }
               else if(3 - val >= 0)
               {
                  _fightNum = 3 - val + count;
               }
               else
               {
                  _fightNum = count;
               }
               if(_fightNum > 0)
               {
                  NpcDialog.show(648,"紫煞",[[0,"你很有胆量！准备好了吗？今天只有<font color=\'#FF0000\'>" + _fightNum + "</font>次挑战的机会！"]],["挑战吧！","准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(FIGHT_BOSS_INDEX);
                  }]);
               }
               else
               {
                  NpcDialog.show(648,"紫煞",[[0,"你已经没有机会了！明天再次突破12重甲来找我吧！"]],["通过星钻继续挑战"," 明天再说吧"],[function():void
                  {
                     AlertManager.showConfirm("你确定花费8星钻购买本次挑战吗?",function():void
                     {
                        PayManager.buyItem(MI_BUY_LIST[0],function():void
                        {
                           FightManager.startFightWithWild(FIGHT_BOSS_INDEX);
                        });
                     });
                  }]);
               }
            });
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function ziDianSuperProcessDispose() : void
      {
         this.clearNpc();
         this.clearOpenMenu();
         this.clearPetList();
         this._resLib = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.ziDianSuperProcessDispose();
      }
   }
}
