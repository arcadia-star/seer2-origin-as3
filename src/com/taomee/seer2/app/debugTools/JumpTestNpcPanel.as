package com.taomee.seer2.app.debugTools
{
   import com.adobe.serialization.json.JSON;
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.component.Combobox;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.activity.npcPosHandle.NpcPosHandle;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.TextField;
   
   public class JumpTestNpcPanel extends Sprite
   {
      
      public static var _instance:JumpTestNpcPanel;
       
      
      private var _mainUI:MovieClip;
      
      private var _checkBoxMc:MovieClip;
      
      private var _crossSymbleMc:MovieClip;
      
      private var _tabMc:MovieClip;
      
      private var _selectedMc:MovieClip;
      
      private var _mapIdTxt:TextField;
      
      private var _idTxt:TextField;
      
      private var _countTxt:TextField;
      
      private var _panelJumpBtn:SimpleButton;
      
      private var _mapJumpBtn:SimpleButton;
      
      private var _npcDragSwitchBtn:SimpleButton;
      
      private var _confirmBtn:SimpleButton;
      
      private var _tabBtnList:Vector.<SimpleButton>;
      
      private const _configUrl:String = "http://10.1.1.159/cgi-bin/HelloWorld.exe";
      
      private const _savePanelAndMapUrl:String = "http://10.1.1.159/cgi-bin/SavePanelAndMap/DebugToolSavePanelAndMap.exe";
      
      private var _configLoader:URLLoader;
      
      private var _panelDataLoader:URLLoader;
      
      private var _userId:String;
      
      private var _curIndex:int = 0;
      
      private var _panelListMc:MovieClip;
      
      private var _panelItemMcList:Vector.<MovieClip>;
      
      private var _panelCombobox:Combobox = null;
      
      private var _panelItemArr:Array;
      
      public function JumpTestNpcPanel(param1:InterClass)
      {
         this._panelItemArr = new Array();
         super();
         if(_instance)
         {
            throw new Error("(跳转、测试、拖动NPC)重复实例化");
         }
         this._mainUI = UIManager.getMovieClip("JumpTestNpcUI");
         addChild(this._mainUI);
         this.initset();
         this.initEvent();
         this.updatePanelListItem(0);
      }
      
      public static function instance() : JumpTestNpcPanel
      {
         if(_instance == null)
         {
            _instance = new JumpTestNpcPanel(new InterClass());
         }
         return _instance;
      }
      
      private function initset() : void
      {
         this._checkBoxMc = this._mainUI["checkboxMc"];
         this._checkBoxMc.mouseChildren = this._checkBoxMc.mouseEnabled = false;
         this._crossSymbleMc = this._mainUI["crossSymble"];
         this._crossSymbleMc.mouseChildren = this._crossSymbleMc.mouseEnabled = false;
         this._panelJumpBtn = this._mainUI["panelJumpBtn"];
         this._mapJumpBtn = this._mainUI["mapJumpBtn"];
         this._npcDragSwitchBtn = this._mainUI["npcDragSwitchBtn"];
         this._confirmBtn = this._mainUI["confirmBtn"];
         this._mapIdTxt = this._mainUI["mapIdTxt"];
         this._mapIdTxt.text = "";
         this._idTxt = this._mainUI["idTxt"];
         this._idTxt.text = "";
         this._countTxt = this._mainUI["countTxt"];
         this._countTxt.text = "";
         var _loc1_:int = 0;
         this._panelListMc = this._mainUI["mapDropboxMc"]["listMc"];
         this._panelItemMcList = new Vector.<MovieClip>();
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            this._panelItemMcList.push(this._panelListMc["contentMc"]["itemMc" + _loc1_]);
            _loc1_++;
         }
         this._panelCombobox = new Combobox(this._mainUI["mapDropboxMc"]);
         this._panelCombobox.pageSize = 8;
         this._tabMc = this._mainUI["tabMc"];
         this._selectedMc = this._tabMc["selectedMc"];
         this._tabBtnList = new Vector.<SimpleButton>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this._tabBtnList.push(this._tabMc["tabBtn" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         this._panelJumpBtn.addEventListener(MouseEvent.CLICK,this.onPanelJumpBtn);
         this.addPanelItem("XueyushengdianSwapPanel");
         this.addPanelItem("VIPDarkSeniorBoxPanel");
         this.addPanelItem("EnergyLotteryPanel");
         this.addPanelItem("ChristmasDayGiveHolyYitePanel");
         this.addPanelItem("LeiYiWingFirstComePanel");
         this.addPanelItem("XiaoMengSongXingZuanPanel");
         this.addPanelItem("Double11BuyPanel");
         this.addPanelItem("ShootDiceForRidesPanel");
         this.addPanelItem("SaDanProtectPanel");
         this.addPanelItem("OreSwapPanel");
         this.addPanelItem("ChuanShuoZhuiSuRewardPanel");
         this.addPanelItem("MidAutumnGiftPanel");
         this.addPanelItem("PetSmeltingActPanel");
         this.addPanelItem("SixStarPrizePanel");
         this.addPanelItem("HunDunMirrorPanel");
         this._mapJumpBtn.addEventListener(MouseEvent.CLICK,this.onMapJumpBtn);
         this._npcDragSwitchBtn.addEventListener(MouseEvent.CLICK,this.onNpcSwitchBtn);
         this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirmBtn);
         this._mainUI["testDialogBtn"].addEventListener(MouseEvent.CLICK,this.onTestDialogBtnClick);
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._tabBtnList.length)
         {
            this._tabBtnList[_loc1_].addEventListener(MouseEvent.CLICK,this.onTabBtn);
            _loc1_++;
         }
         this.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this._panelCombobox.addScrollerListener(this.onScroll);
         _loc1_ = 0;
         while(_loc1_ < this._panelItemMcList.length)
         {
            this._panelItemMcList[_loc1_].addEventListener(MouseEvent.CLICK,this.onPanelItemMc);
            _loc1_++;
         }
      }
      
      public function getConfigData(param1:uint) : void
      {
         var _loc2_:URLRequest = new URLRequest(this._configUrl);
         var _loc3_:URLVariables = new URLVariables();
         this._userId = param1.toString();
         _loc3_.p0 = 4;
         _loc3_.p1 = this._userId;
         _loc2_.data = _loc3_;
         _loc2_.method = URLRequestMethod.POST;
         if(this._configLoader == null)
         {
            this._configLoader = new URLLoader();
         }
         this._configLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
         this._configLoader.addEventListener(Event.COMPLETE,this.onUrlLoaderComplete);
         this._configLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
         this._configLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._configLoader.load(_loc2_);
      }
      
      private function setConfigData(param1:String, param2:URLVariables) : void
      {
         var _loc3_:URLRequest = new URLRequest(param1);
         _loc3_.data = param2;
         _loc3_.method = URLRequestMethod.POST;
         if(this._configLoader == null)
         {
            this._configLoader = new URLLoader();
         }
         this._configLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
         this._configLoader.load(_loc3_);
      }
      
      private function onUrlLoaderComplete(param1:Event) : void
      {
         var _loc3_:String = null;
         URLLoader(param1.currentTarget).removeEventListener(Event.COMPLETE,this.onUrlLoaderComplete);
         var _loc2_:Object = URLLoader(param1.currentTarget).data;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.hasOwnProperty("p1"))
         {
            if(_loc2_["p1"] == "" || _loc2_["p1"] == "0")
            {
               this._crossSymbleMc.visible = false;
               NpcPosHandle.setMovableState(false);
            }
            else
            {
               this._crossSymbleMc.visible = true;
               NpcPosHandle.setMovableState(true);
            }
         }
      }
      
      private function onPanelDataComplete(param1:Event) : void
      {
         var _loc3_:String = null;
         URLLoader(param1.currentTarget).removeEventListener(Event.COMPLETE,this.onPanelDataComplete);
         var _loc2_:Object = URLLoader(param1.currentTarget).data;
         if(_loc2_ == null)
         {
            return;
         }
         this._panelItemArr.length = 0;
         var _loc4_:int = 0;
         _loc4_ = 1;
         while(_loc4_ <= 20)
         {
            if(_loc2_.hasOwnProperty("p" + _loc4_))
            {
               this._panelItemArr.push(_loc2_["p" + _loc4_]);
            }
            _loc4_++;
         }
         if(this._panelItemArr.length > 0)
         {
            this._panelCombobox.editorTxt = this._panelItemArr[0];
            this._panelCombobox.maxScrollPosition = this._panelItemArr.length;
         }
         this.updatePanelListItem(0);
      }
      
      private function onIoError(param1:IOErrorEvent) : void
      {
         URLLoader(param1.currentTarget).removeEventListener(Event.COMPLETE,this.onUrlLoaderComplete);
         URLLoader(param1.currentTarget).removeEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
      }
      
      private function onHttpStatus(param1:HTTPStatusEvent) : void
      {
         URLLoader(param1.currentTarget).removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         if(param1.status == 404)
         {
            URLLoader(param1.currentTarget).removeEventListener(Event.COMPLETE,this.onUrlLoaderComplete);
            URLLoader(param1.currentTarget).removeEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
            throw new Error("CGI应用程序 " + this._configUrl + "JumpTestNpcPanel.getConfigData()");
         }
      }
      
      public function getPanelData(param1:uint) : void
      {
         var _loc2_:URLRequest = new URLRequest(this._savePanelAndMapUrl);
         var _loc3_:URLVariables = new URLVariables();
         this._userId = param1.toString();
         _loc3_.p0 = 2;
         _loc3_.p1 = this._userId;
         _loc2_.data = _loc3_;
         _loc2_.method = URLRequestMethod.POST;
         if(this._panelDataLoader == null)
         {
            this._panelDataLoader = new URLLoader();
         }
         this._panelDataLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
         this._panelDataLoader.addEventListener(Event.COMPLETE,this.onPanelDataComplete);
         this._panelDataLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIoError);
         this._panelDataLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._panelDataLoader.load(_loc2_);
      }
      
      private function onPanelJumpBtn(param1:MouseEvent) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:int = 0;
         if(this._panelCombobox.editorTxt != "")
         {
            ModuleManager.showAppModule(this._panelCombobox.editorTxt);
            if(this._panelItemArr.indexOf(this._panelCombobox.editorTxt) != 0)
            {
               this.addPanelItem(this._panelCombobox.editorTxt);
               _loc2_ = new URLVariables();
               _loc2_.p0 = 1;
               _loc2_.p1 = this._userId;
               _loc3_ = 0;
               _loc3_ = 0;
               while(_loc3_ < this._panelItemArr.length)
               {
                  _loc2_["p" + (_loc3_ + 2)] = this._panelItemArr[_loc3_];
                  _loc3_++;
               }
               //this.setConfigData(this._savePanelAndMapUrl,_loc2_);
            }
         }
      }
      
      private function onMapJumpBtn(param1:MouseEvent) : void
      {
         if(this._mapIdTxt.text != "")
         {
            ActsHelperUtil.goHandle(int(this._mapIdTxt.text));
            this.addPanelItem(this._panelCombobox.editorTxt);
         }
      }
      
      private function onNpcSwitchBtn(param1:MouseEvent) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.p0 = 3;
         _loc2_.p1 = this._userId;
         if(this._crossSymbleMc.visible)
         {
            this._crossSymbleMc.visible = false;
            NpcPosHandle.setMovableState(false);
            _loc2_.p2 = 0;
         }
         else
         {
            this._crossSymbleMc.visible = true;
            NpcPosHandle.setMovableState(true);
            _loc2_.p2 = 1;
         }
         //this.setConfigData(this._configUrl,_loc2_);
      }
      
      private function onTestDialogBtnClick(param1:*) : void
      {
         var dialogs:Array = null;
         var e:* = param1;
         var text:String = String(this._mainUI["dialogTxt"].text);
         if(text.indexOf(".json") != -1)
         {
            NpcDialog.showDialogsByText(text,function():void
            {
            });
            return;
         }
         try
         {
            dialogs = com.adobe.serialization.json.JSON.decode(text);
         }
         catch(e:*)
         {
            AlertManager.showAlert("json 格式错误");
            return;
         }
         NpcDialog.showDialogs(dialogs,function():void
         {
         });
      }
      
      private function onConfirmBtn(param1:MouseEvent) : void
      {
      }
      
      private function onTabBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = this._tabBtnList.indexOf(param1.currentTarget as SimpleButton);
         if(_loc2_ == this._curIndex)
         {
            return;
         }
         TweenLite.to(this._selectedMc,0.5,{
            "x":this._tabBtnList[_loc2_].x,
            "y":this._tabBtnList[_loc2_].y
         });
         this._curIndex = _loc2_;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            param1.stopPropagation();
         }
      }
      
      private function onScroll() : void
      {
         var _loc1_:int = this._panelCombobox.scrollPosition;
         this.updatePanelListItem(_loc1_);
      }
      
      private function updatePanelListItem(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this._panelItemMcList.length)
         {
            if(_loc2_ < this._panelItemArr.length)
            {
               this._panelItemMcList[_loc2_]["idTxt"].text = this._panelItemArr[_loc2_ + param1];
               this._panelItemMcList[_loc2_].visible = true;
            }
            else
            {
               this._panelItemMcList[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function onPanelItemMc(param1:MouseEvent) : void
      {
         var _loc2_:int = this._panelItemMcList.indexOf(param1.currentTarget as MovieClip);
         var _loc3_:int = this._panelCombobox.scrollPosition;
         this._panelCombobox.editorTxt = this._panelItemArr[_loc2_ + _loc3_];
      }
      
      private function addPanelItem(param1:String) : void
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         _loc3_ = this._panelItemArr.indexOf(param1);
         if(_loc3_ == -1)
         {
            if(this._panelItemArr.length > 20)
            {
               this._panelItemArr.pop();
            }
            this._panelItemArr.unshift(param1);
         }
         else
         {
            _loc2_ = this._panelItemArr.splice(_loc3_,1);
            this._panelItemArr.unshift(_loc2_);
         }
         this._panelCombobox.maxScrollPosition = this._panelItemArr.length;
         this.updatePanelListItem(0);
      }
   }
}

class InterClass
{
    
   
   public function InterClass()
   {
      super();
   }
}
