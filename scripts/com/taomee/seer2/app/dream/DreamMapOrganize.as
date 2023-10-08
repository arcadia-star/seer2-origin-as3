package com.taomee.seer2.app.dream
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.controls.petAvatarPanel.PetItem;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.DreamPet;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.pet.events.PetInfoEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.config.DreamConfig;
   import com.taomee.seer2.core.config.DreamInfo;
   import com.taomee.seer2.core.config.DreamPetInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   import org.taomee.utils.StringUtil;
   
   public class DreamMapOrganize extends Sprite
   {
      
      private static var _instance:com.taomee.seer2.app.dream.DreamMapOrganize;
      
      private static var _mapInfo:com.taomee.seer2.app.dream.DreamMapInfo;
       
      
      private var _petList:Vector.<PetItem>;
      
      private var _petListBg:MovieClip;
      
      private var _dreamMapRightPanel:MovieClip;
      
      private var _dreamRecoverBtn:SimpleButton;
      
      private var _info:DreamInfo;
      
      private var _starList:Vector.<MovieClip>;
      
      private var _infoTxtList:Vector.<TextField>;
      
      private var _comTxtList:Vector.<MovieClip>;
      
      private var _info2Txt:TextField;
      
      private var _info3Txt:TextField;
      
      private var _info2ComTxt:MovieClip;
      
      private var _info3ComTxt:MovieClip;
      
      private var _shopBtn:SimpleButton;
      
      private var _bossInfoList:Vector.<DreamPetInfo>;
      
      private var _bossList:Vector.<DreamPet>;
      
      private var _oldCoinNum:uint;
      
      private var _recoverBtn:SimpleButton;
      
      public function DreamMapOrganize()
      {
         super();
         this._petListBg = UIManager.getMovieClip("PetItemListBg");
         this._petListBg.mouseChildren = false;
         this._petListBg.mouseEnabled = false;
         this._dreamMapRightPanel = UIManager.getMovieClip("DreamMapRightPanel");
         this._dreamRecoverBtn = UIManager.getButton("DreamRecoverBtn");
         this._dreamRecoverBtn.addEventListener(MouseEvent.CLICK,this.onRecover);
         TooltipManager.addCommonTip(this._dreamRecoverBtn,"恢复全部精灵体力");
         this._dreamRecoverBtn.x = 182;
         this._dreamMapRightPanel.x = 980;
         this.initDreamMapRightPanel();
      }
      
      private static function get instance() : com.taomee.seer2.app.dream.DreamMapOrganize
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.dream.DreamMapOrganize();
         }
         return _instance;
      }
      
      public static function show() : void
      {
         LayerManager.mapLayer.addChild(instance);
         instance.dreamEntryMap();
      }
      
      public static function layout() : void
      {
         if(instance)
         {
            instance.layout();
         }
      }
      
      public static function setInfo(param1:com.taomee.seer2.app.dream.DreamMapInfo) : void
      {
         _mapInfo = param1;
      }
      
      public static function updateDream() : void
      {
         instance.entryMap2();
      }
      
      public static function dispose() : void
      {
         if(instance)
         {
            DisplayObjectUtil.removeFromParent(instance);
            instance.disposeDream();
         }
      }
      
      private function layout() : void
      {
         if(this._dreamMapRightPanel == null || this._dreamRecoverBtn == null || this._petListBg == null || this._petList == null)
         {
            return;
         }
         this._dreamMapRightPanel.x = LayerManager.stage.stageWidth - 210;
         this._dreamMapRightPanel.y = 660 - LayerManager.stage.stageHeight;
         this._dreamRecoverBtn.y = 660 - LayerManager.stage.stageHeight;
         this._petListBg.y = 660 - LayerManager.stage.stageHeight;
         var _loc1_:int = 0;
         while(_loc1_ < this._petList.length)
         {
            this._petList[_loc1_].y = 660 - LayerManager.stage.stageHeight + 37 + 57 * _loc1_;
            _loc1_++;
         }
      }
      
      private function initDreamMapRightPanel() : void
      {
         this._starList = Vector.<MovieClip>([]);
         this._infoTxtList = Vector.<TextField>([]);
         this._comTxtList = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._starList.push(this._dreamMapRightPanel["star" + _loc1_]);
            this._infoTxtList.push(this._dreamMapRightPanel["infoTxt" + _loc1_]);
            this._comTxtList.push(this._dreamMapRightPanel["comTxt" + _loc1_]);
            _loc1_++;
         }
         this._info2Txt = this._dreamMapRightPanel["info2Txt"];
         this._info3Txt = this._dreamMapRightPanel["info3Txt"];
         this._info2ComTxt = this._dreamMapRightPanel["info2ComTxt"];
         this._info3ComTxt = this._dreamMapRightPanel["info3ComTxt"];
         this._shopBtn = this._dreamMapRightPanel["shopBtn"];
         this._shopBtn.addEventListener(MouseEvent.CLICK,this.onShop);
      }
      
      private function onShop(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("DreamShopPanel"),"");
      }
      
      private function disposeDream() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().blockNoNo = false;
         ActorManager.getActor().blockFollowingPet = false;
         DisplayUtil.removeForParent(this._petListBg);
         DisplayUtil.removeForParent(this._dreamMapRightPanel);
         DisplayUtil.removeForParent(this._dreamRecoverBtn);
         Connection.removeCommandListener(CommandSet.DREAM_CURR_MAP_INFO_1558,this.onDreamEntryMap);
         UILoader.cancel(URLUtil.getRes("dream/dreamOneEntry.swf"),this.onLoadAnimation);
      }
      
      private function hideMapContent() : void
      {
         var _loc3_:InteractiveObject = null;
         var _loc1_:Sprite = SceneManager.active.mapModel.content;
         var _loc2_:int = _loc1_.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_.getChildAt(_loc4_) as InteractiveObject;
            if(_loc3_ != null)
            {
               if(this.hasGivenName(_loc3_))
               {
                  _loc3_.visible = false;
               }
            }
            _loc4_++;
         }
      }
      
      private function hasGivenName(param1:InteractiveObject) : Boolean
      {
         var _loc2_:String = "instance";
         var _loc3_:String = param1.name;
         if(_loc3_ == null || _loc3_ == "" || Boolean(StringUtil.beginsWith(_loc3_,_loc2_)) || _loc3_ == "离开梦境")
         {
            return false;
         }
         return true;
      }
      
      private function dreamEntryMap() : void
      {
         this.hideMapContent();
         MapTitlePanel.hide();
         this.hideSceneUI();
         this.hideNpc();
         ActorManager.getActor().blockNoNo = true;
         ActorManager.getActor().blockFollowingPet = true;
         this._info = DreamConfig.getInfo(SceneManager.active.mapID);
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this._info.isWelfare)
            {
               this.disposeDream();
               SceneManager.changeScene(SceneType.LOBBY,3840);
               return;
            }
            Connection.addCommandListener(CommandSet.DREAM_CURR_MAP_INFO_1558,this.onDreamEntryMap);
            Connection.releaseCommand(CommandSet.DREAM_CURR_MAP_INFO_1558);
         }
         else
         {
            this.entryMap();
            this.dreamCheckOne();
            this.showBox();
         }
      }
      
      private function showBox() : void
      {
         if(_mapInfo.goldenBoxCount != 0 || _mapInfo.sliverBoxCount != 0)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DreamOnePlay"),function():void
            {
               var _loc1_:int = 0;
               while(_loc1_ < _mapInfo.goldenBoxCount)
               {
                  new DreamBox(0);
                  _loc1_++;
               }
               var _loc2_:int = 0;
               while(_loc2_ < _mapInfo.sliverBoxCount)
               {
                  new DreamBox(1);
                  _loc2_++;
               }
            });
         }
      }
      
      private function dreamCheckOne() : void
      {
         if(this._info.id == 1)
         {
            DreamOneEntry.getCurrQuestIndex(function(param1:int):void
            {
               var _loc2_:int = 0;
               var _loc3_:int = 0;
               if(param1 == 4)
               {
                  NpcDialog.show(766,"小梦",[[0,"在挑战那些头顶王冠的BOSS前，我们要先战胜它的小弟。记住：不要有精灵死亡哦！"]],["（去挑战2只法娜）"]);
                  ServerBufferManager.updateServerBuffer(ServerBufferType.DREAM_ONE_ENTRY,4,1);
               }
               else if(param1 == 5)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _mapInfo.list.length)
                  {
                     if(_mapInfo.list[_loc2_].isBoss == 0)
                     {
                        _loc3_ = _mapInfo.list[_loc2_].totalPetCount - _mapInfo.list[_loc2_].killPetCount;
                        if(_loc3_ == 0)
                        {
                           UILoader.load(URLUtil.getRes("dream/dreamOneEntry.swf"),LoadType.DOMAIN,onLoadAnimation);
                        }
                     }
                     _loc2_++;
                  }
               }
            });
         }
      }
      
      private function onLoadAnimation(param1:ContentInfo) : void
      {
         var playMC:MovieClip = null;
         var info:ContentInfo = param1;
         playMC = DomainUtil.getMovieClip("item",info.content);
         SceneManager.active.mapModel.content.addChild(playMC);
         MovieClipUtil.playMc(playMC,2,playMC.totalFrames,function():void
         {
            DisplayUtil.removeForParent(playMC);
            NpcDialog.show(766,"小梦",[[0,"现在，挑战BOSS吧！加油！"]],["（去挑战呆呆葵）"]);
            ServerBufferManager.updateServerBuffer(ServerBufferType.DREAM_ONE_ENTRY,5,1);
         },true);
      }
      
      private function hideNpc() : void
      {
         var _loc1_:Vector.<Mobile> = MobileManager.getMobileVec(MobileType.NPC);
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_].visible = false;
            _loc2_++;
         }
      }
      
      private function hideSceneUI() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         ActorManager.showRemoteActor = false;
      }
      
      private function onDreamEntryMap(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DREAM_CURR_MAP_INFO_1558,this.onDreamEntryMap);
         var _loc2_:IDataInput = param1.message.getRawData();
         _mapInfo = new com.taomee.seer2.app.dream.DreamMapInfo(_loc2_);
         this.entryMap();
         this.dreamCheckOne();
         this.showBox();
      }
      
      private function entryMap() : void
      {
         this.addPet();
         this.onPetListShow();
         this.dreamRightShow();
         this.checkFight();
      }
      
      private function entryMap2() : void
      {
         this.removePet();
         this.addPet();
         this.onPetListShow();
         this.dreamRightShow();
      }
      
      private function removePet() : void
      {
         MobileManager.clearMobileVec(MobileType.SPAWNED_PET);
      }
      
      private function checkFight() : void
      {
         var _loc1_:Object = null;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.isWinWar() == false)
            {
               this._info = DreamConfig.getInfo(SceneManager.active.mapID);
               _loc1_ = new Object();
               _loc1_.info = this._info;
               ModuleManager.showModule(URLUtil.getAppModule("DreamFailedPanel"),"",_loc1_);
            }
            else if(_mapInfo.isComWinMap)
            {
               _loc1_ = new Object();
               _loc1_.info = _mapInfo;
               ModuleManager.showModule(URLUtil.getAppModule("DreamWinPanel"),"",_loc1_);
            }
         }
      }
      
      private function checkWin() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < _mapInfo.list.length)
         {
            if(_mapInfo.list[_loc1_].killPetCount < _mapInfo.list[_loc1_].totalPetCount)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function addPet() : void
      {
         var _loc1_:DreamPet = null;
         var _loc2_:DreamPetInfo = null;
         var _loc4_:int = 0;
         var _loc5_:DreamPet = null;
         var _loc6_:int = 0;
         this._bossInfoList = Vector.<DreamPetInfo>([]);
         this._bossList = Vector.<DreamPet>([]);
         var _loc3_:int = 0;
         while(_loc3_ < _mapInfo.list.length)
         {
            _loc4_ = _mapInfo.list[_loc3_].totalPetCount - _mapInfo.list[_loc3_].killPetCount;
            if(_mapInfo.list[_loc3_].isBoss == 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  _loc5_ = new DreamPet(_mapInfo.list[_loc3_].petId,_mapInfo.fightId,0,false);
                  MobileManager.addMobile(_loc5_,MobileType.SPAWNED_PET);
                  _loc6_++;
               }
            }
            else if(_mapInfo.list[_loc3_].killPetCount < 1)
            {
               _loc2_ = this._info.getBossInfo(_mapInfo.list[_loc3_].petId);
               _loc1_ = new DreamPet(_mapInfo.list[_loc3_].petId,_mapInfo.fightId,_loc2_.level,true,_mapInfo);
               this._bossList.push(_loc1_);
               MobileManager.addMobile(_loc1_,MobileType.SPAWNED_PET);
               this._bossInfoList.push(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function dreamRightShow() : void
      {
         _instance.addChild(this._dreamMapRightPanel);
         _instance.addChild(this._dreamRecoverBtn);
         this._info2ComTxt.visible = false;
         this._info3ComTxt.visible = false;
         this._starList[0].gotoAndStop(2);
         this._starList[1].gotoAndStop(2);
         this._starList[2].gotoAndStop(2);
         this._info3Txt.text = this._info.threeStar;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(this._info.bossList.length > _loc1_)
            {
               this.checkHideRightStar1(_loc1_,false);
               this._infoTxtList[_loc1_].text = "击败" + PetConfig.getPetDefinition(this._info.bossList[_loc1_].id).name;
               if(this.isComBoss(_loc1_) == false)
               {
                  this._comTxtList[_loc1_].visible = false;
               }
            }
            else
            {
               this.checkHideRightStar1(_loc1_,true);
            }
            _loc1_++;
         }
      }
      
      private function isComBoss(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < _mapInfo.list.length)
         {
            if(_mapInfo.list[_loc2_].petId == this._info.bossList[param1].id && _mapInfo.list[_loc2_].killPetCount >= 1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function checkHideRightStar1(param1:int, param2:Boolean) : void
      {
         this._infoTxtList[param1].visible = !param2;
         this._comTxtList[param1].visible = !param2;
      }
      
      private function onRecover(param1:MouseEvent) : void
      {
         this._oldCoinNum = ActorManager.actorInfo.coins;
         this.recoverAllPetBagPet();
      }
      
      private function recoverAllPetBagPet() : void
      {
         Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         Connection.send(CommandSet.TREAT_ALL_PET_1215);
      }
      
      private function onAddAllPetBlood(param1:MessageEvent) : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:int = 0;
         var _loc5_:PetItem = null;
         Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,this.onAddAllPetBlood);
         var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
         for each(_loc3_ in _loc2_)
         {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc3_);
         }
         _loc4_ = int(param1.message.getRawData().readUnsignedInt());
         ActorManager.actorInfo.coins = _loc4_;
         ServerMessager.addMessage("消耗" + (this._oldCoinNum - _loc4_) + "赛尔豆恢复背包中所有精灵！");
         for each(_loc5_ in this._petList)
         {
            _loc5_.update();
         }
      }
      
      public function onPetListShow() : void
      {
         var _loc2_:PetInfo = null;
         var _loc3_:PetItem = null;
         var _loc4_:int = 0;
         _instance.addChild(this._petListBg);
         this._petList = new Vector.<PetItem>();
         var _loc1_:Vector.<PetInfo> = new Vector.<PetInfo>();
         for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
         {
            _loc1_.push(_loc2_);
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = new PetItem();
            _loc3_.mouseChildren = false;
            _loc3_.mouseEnabled = false;
            instance.addChild(_loc3_);
            this._petList.push(_loc3_);
            _loc3_.x = 100;
            _loc3_.y = 2 + (_loc3_.height + 2) * _loc4_ + 37;
            _loc3_.info = _loc1_[_loc4_];
            _loc4_++;
         }
         if(_loc1_.length == 0)
         {
            this._petListBg.height = 0;
         }
         else
         {
            this._petListBg.height = 5 + 57 * _loc1_.length;
         }
         this._petListBg.visible = true;
      }
   }
}
