package com.taomee.seer2.app.popup.alert
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.component.PetPotentialityIcon;
   import com.taomee.seer2.app.component.PetTypeIcon;
   import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
   import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
   import com.taomee.seer2.app.gameRule.door.constant.DoorType;
   import com.taomee.seer2.app.gameRule.door.core.DoorResultSwitchPetPanel;
   import com.taomee.seer2.app.gameRule.door.core.IDoorServerPetable;
   import com.taomee.seer2.app.gameRule.door.core.IMultiSelectable;
   import com.taomee.seer2.app.gameRule.door.hero.HeroDoorSupport;
   import com.taomee.seer2.app.gameRule.door.warrior.WarriorDoorSuport;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class DoorResultAlert extends Sprite implements IAlert
   {
      
      private static const RESULTUIS:Array = ["Door50V50_CoinWinResultUI","TrailsDoor50V50WinResultUI","WarriorDoor50V50WinResultUI","AtleticoDoor50V50WinResultUI","HeroDoor50V50WinResultUI"];
      
      private static const DOOR_TARGETMAPID:Array = [0,82,83,84,85,86,87,88,89];
       
      
      private var _result:Boolean;
      
      private var _petInfo:PetInfo;
      
      private var _doorType:uint = 0;
      
      private var _doorRule:uint = 0;
      
      private var _equipId:uint = 0;
      
      private var _support:IMultiSelectable;
      
      private var _petTypeIcon:PetTypeIcon;
      
      private var _petPanel:MovieClip;
      
      private var _guardPanel:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _doorResultSwitchPetPanel:DoorResultSwitchPetPanel;
      
      private var _icon:IconDisplayer;
      
      private var _closeHandler:Function;
      
      private var _resLoader:ResourceLibraryLoader;
      
      private var _info:AlertInfo;
      
      private var _lib:ResourceLibrary;
      
      public function DoorResultAlert()
      {
         super();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this._info = param1;
         this._result = param1.initInfo.result;
         this._doorType = param1.initInfo.doorType;
         this._doorRule = param1.initInfo.doorRule;
         this._petInfo = param1.initInfo.petInfo;
         this._equipId = param1.initInfo.equipId;
         this._closeHandler = param1.initInfo.closeHandler;
         this.initialize();
      }
      
      public function dispose() : void
      {
         this._resLoader.dispose();
         if(this._closeHandler != null)
         {
            this._closeHandler();
         }
         this._closeHandler = null;
         this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirmHandler);
         this._confirmBtn = null;
         LayerManager.resetOperation();
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function initialize() : void
      {
         this._resLoader = new ResourceLibraryLoader(URLUtil.getRes("publicRes/doorResult" + URLUtil.POSTFIX_SWF));
         this._resLoader.getLib(this.onGetLib);
      }
      
      private function onGetLib(param1:ResourceLibrary) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         this._lib = param1;
         this._icon = new IconDisplayer();
         if(this._result)
         {
            if(this._doorType == DoorType.Door_NORMAL)
            {
               if(this._doorRule == DoorRule.TRAIL_DOOR || this._doorRule == DoorRule.BINARY_DOOR)
               {
                  _loc2_ = param1.getMovieClip("DoorWinResultUI");
                  this._petPanel = _loc2_["petPanel"];
                  this.updatePetInfo();
               }
               else if(this._doorRule == DoorRule.WARRIOR_DOOR || this._doorRule == DoorRule.ATLETICO_DOOR || this._doorRule == DoorRule.HERO_DOOR)
               {
                  _loc3_ = this._petInfo.resourceId;
                  if(this._doorRule == DoorRule.WARRIOR_DOOR)
                  {
                     this._support = WarriorDoorSuport.getInstance();
                  }
                  else if(this._doorRule == DoorRule.ATLETICO_DOOR)
                  {
                     this._support = AtleticoDoorSupport.getInstance();
                  }
                  else if(this._doorRule == DoorRule.HERO_DOOR)
                  {
                     this._support = HeroDoorSupport.getInstance();
                  }
                  this._doorResultSwitchPetPanel = new DoorResultSwitchPetPanel(_loc3_,this._support.rewardIDList);
                  this._doorResultSwitchPetPanel.addEventListener(DoorResultSwitchPetPanel.LOAD_COMPLETE_SHOW_PANEL,this.onLoadCompleteShowPanel);
                  this._doorResultSwitchPetPanel.addEventListener(DoorResultSwitchPetPanel.SELECT_SWITCH_COMPLETE,this.onSwitchComplete);
                  addChild(this._doorResultSwitchPetPanel);
                  return;
               }
            }
            else if(this._doorType == DoorType.Door_50V50)
            {
               if(this._equipId == 1)
               {
                  _loc2_ = param1.getMovieClip(RESULTUIS[0]);
               }
               else
               {
                  _loc2_ = param1.getMovieClip(RESULTUIS[this._doorRule]);
                  this._guardPanel = _loc2_["guard"];
                  this.updateGuardInfo();
               }
            }
         }
         else
         {
            _loc2_ = param1.getMovieClip("DoorFailureResultUI");
         }
         addChild(_loc2_);
         AlertManager.addPopUp(this._info,this);
         this._confirmBtn = _loc2_["confirmBtn"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmHandler);
      }
      
      private function onLoadCompleteShowPanel(param1:Event) : void
      {
         this._doorResultSwitchPetPanel.removeEventListener(DoorResultSwitchPetPanel.LOAD_COMPLETE_SHOW_PANEL,this.onLoadCompleteShowPanel);
         AlertManager.addPopUp(this._info,this);
      }
      
      private function onConfirmHandler(param1:MouseEvent) : void
      {
         this.dispose();
         if(this._result == false || this._doorRule != DoorRule.BINARY_DOOR)
         {
            Connection.send(CommandSet.DOOR_OUT_1049);
            SceneManager.changeScene(SceneType.LOBBY,DOOR_TARGETMAPID[this._doorRule]);
         }
      }
      
      private function onSwitchComplete(param1:Event) : void
      {
         this._doorResultSwitchPetPanel.removeEventListener(DoorResultSwitchPetPanel.SELECT_SWITCH_COMPLETE,this.onSwitchComplete);
         setTimeout(this.showGetPetPanel,1000);
      }
      
      private function showGetPetPanel() : void
      {
         removeChild(this._doorResultSwitchPetPanel);
         this._doorResultSwitchPetPanel.dispose();
         this._doorResultSwitchPetPanel = null;
         var _loc1_:MovieClip = this._lib.getMovieClip("DoorWinResultUI");
         _loc1_.y = 60;
         this._petPanel = _loc1_["petPanel"];
         this.updatePetInfo();
         addChild(_loc1_);
         LayerManager.focusOnTopLayer();
         var _loc2_:uint = (this._support as IDoorServerPetable).petId;
         var _loc3_:uint = (this._support as IDoorServerPetable).resourceId;
         this._support.rewardIDList = null;
         PetInfoManager.requestAddToBagFromStorage(_loc2_,_loc3_);
         this._confirmBtn = _loc1_["confirmBtn"];
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmHandler);
      }
      
      private function updateGuardInfo() : void
      {
         if(this._equipId != 0)
         {
            this._guardPanel.gotoAndPlay("equip_" + this._equipId);
         }
      }
      
      private function updatePetInfo() : void
      {
         var onContentLoaded:Function;
         var potentiality:PetPotentialityIcon = null;
         var url:String = null;
         if(this._petInfo != null)
         {
            onContentLoaded = function():void
            {
               _icon.scaleY = _icon.scaleX = 1.5;
               _icon.x = _icon.y = 3;
               Sprite(_petPanel["content"]).addChildAt(_icon,0);
            };
            TextField(this._petPanel["petInfo"]).text = this._petInfo.description;
            TextField(this._petPanel["att"]).text = String(this._petInfo.atk);
            TextField(this._petPanel["def"]).text = String(this._petInfo.defence);
            TextField(this._petPanel["satt"]).text = String(this._petInfo.specialAtk);
            TextField(this._petPanel["sdef"]).text = String(this._petInfo.specialDefence);
            TextField(this._petPanel["speed"]).text = String(this._petInfo.speed);
            TextField(this._petPanel["wweight"]).text = String(this._petInfo.maxHp);
            TextField(this._petPanel["sequ"]).text = String(this._petInfo.resourceId);
            TextField(this._petPanel["petName"]).text = this._petInfo.name;
            TextField(this._petPanel["petlev"]).text = String(this._petInfo.level);
            TextField(this._petPanel["levelTxt"]).text = String(this._petInfo.level);
            TextField(this._petPanel["chara"]).text = this._petInfo.characterName;
            this._petPanel["sexx"].gotoAndStop(this._petInfo.sex);
            potentiality = new PetPotentialityIcon();
            potentiality.setPotential(this._petInfo.potential,this._petInfo.isAggraisal);
            potentiality.x = 230;
            potentiality.y = 20;
            this._petPanel.addChild(potentiality);
            url = String(URLUtil.getPetIcon(this._petInfo.resourceId));
            this._icon.setIconUrl(url,onContentLoaded);
            this.createPetTypeIcon();
            this._petTypeIcon.type = this._petInfo.type;
         }
      }
      
      private function createPetTypeIcon() : void
      {
         this._petTypeIcon = new PetTypeIcon();
         (this._petPanel["content"] as MovieClip).addChild(this._petTypeIcon);
         this._petTypeIcon.x = this._petTypeIcon.y = -3;
      }
   }
}
