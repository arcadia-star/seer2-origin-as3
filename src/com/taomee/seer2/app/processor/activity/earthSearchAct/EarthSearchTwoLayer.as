package com.taomee.seer2.app.processor.activity.earthSearchAct
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.inventory.Item;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class EarthSearchTwoLayer
   {
       
      
      private const TIME_SWP:int = 3539;
      
      private const NEXT_SWP:int = 3540;
      
      private const NPC_ID:int = 836;
      
      private const ITEM_ID:Vector.<int> = Vector.<int>([401091]);
      
      private const POS:Vector.<int> = Vector.<int>([700,390]);
      
      private const FUNC_STR:Vector.<String> = Vector.<String>(["岩石阵挑战开始","熔浆阵挑战开始","对流阵挑战开始"]);
      
      private const DIALOG_STR:Vector.<String> = Vector.<String>(["游戏刚刚开始呢，先过岩石阵吧！","熔浆阵可不是和你闹着玩的！这次的挑战让你终身难忘！","我们从来不敢在对流阵里玩！你确定要去试试吗？","你已经全部挑战完喽!"]);
      
      private var _mapModel:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _curHandle:EarthSearchTwoHandle;
      
      private var _npc:Mobile;
      
      private var _self:EarthSearchTwoLayer;
      
      private var _type:int;
      
      public function EarthSearchTwoLayer(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this._self = this;
         this.init();
      }
      
      public function set resLib(param1:ApplicationDomain) : void
      {
         this._resLib = param1;
      }
      
      private function init() : void
      {
         EarthSearchTwoManager.inistance().addObj(this);
      }
      
      public function initSet(param1:Array) : void
      {
         this._type = param1[0];
         this._curHandle = new EarthSearchTwoHandle(param1[0]);
         this._curHandle.initSet([this._resLib,this._mapModel,this._self,param1[1],param1[2]]);
      }
      
      public function initEvent() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
      
      private function onDialogShow(param1:Event) : void
      {
         var evt:Event = param1;
         ItemManager.requestItemList(function():void
         {
            DialogPanel.showForSimple(NPC_ID,"小地兽",[[0,DIALOG_STR[_type] + "你也可以给我<font color=\'#ff3300\'>20</font>个电池直接进入地核层,我知道你现在已经有<font color=\'#ff3300\'>" + getItemNum(ITEM_ID[0]) + "</font>块电池了。"]]," 我准备一下");
            addUinit();
         });
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set curHandle(param1:EarthSearchTwoHandle) : void
      {
         this._curHandle = param1;
      }
      
      public function get curHandle() : EarthSearchTwoHandle
      {
         return this._curHandle;
      }
      
      private function addUinit() : void
      {
         var _loc3_:BaseUnit = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         DialogPanel.addFunctionalityBox();
         var _loc1_:Vector.<String> = Vector.<String>(["电池购买","地幔层规则","进入地核层"]);
         if(this._type <= 2)
         {
            _loc1_.push(this.FUNC_STR[this._type]);
         }
         var _loc2_:Vector.<String> = Vector.<String>(["EarthBuy","EarthRule","80372","EarthReadyGo"]);
         for each(_loc5_ in _loc1_)
         {
            if(_loc4_ <= 1)
            {
               _loc3_ = new CustomUnit(FunctionalityType.MODULE,_loc5_,_loc2_[_loc4_]);
            }
            else
            {
               _loc3_ = new CustomUnit(FunctionalityType.ACTIVE,_loc5_,_loc2_[_loc4_]);
            }
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc4_++;
         }
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function onUint(param1:DialogPanelEvent) : void
      {
         var num:int = 0;
         var evt:DialogPanelEvent = param1;
         var params:String = String(evt.content.params);
         if(params == "EarthBuy")
         {
            ModuleManager.showAppModule("EarthItemBuyPanel");
         }
         if(params == "EarthRule")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("EarthActIntroduceTwoPanel"),"打开规则...");
         }
         if(params == "80372")
         {
            num = this.getItemNum(this.ITEM_ID[0]);
            if(num < 20)
            {
               NpcDialog.show(this.NPC_ID,"小地兽",[[0,"1、2、3、6、5、9、8……虽然我的数学课是体育老师教的，但是也算的出你给的电池不够啊！ 要不要买点啊？"]],["购买电池 ","知道了"],[function():void
               {
                  ModuleManager.showAppModule("EarthItemBuyPanel");
               }]);
            }
            else
            {
               SwapManager.swapItem(this.NEXT_SWP,1,function(param1:IDataInput):void
               {
                  var _loc2_:SwapInfo = new SwapInfo(param1);
                  SceneManager.changeScene(SceneType.COPY,80372);
               },null,new SpecialInfo(1,1));
            }
         }
         if(params == "EarthReadyGo")
         {
            AlertManager.showConfirm("倒计时开始，你确定开始挑战吗？",function():void
            {
               hideNpc();
               SwapManager.swapItem(TIME_SWP,1,function(param1:IDataInput):void
               {
                  var _loc2_:SwapInfo = new SwapInfo(param1,false);
                  if(_curHandle == null)
                  {
                     initSet([EarthSearchTwoManager.inistance().type,0,0]);
                     curHandle.initHandle();
                  }
                  _curHandle.start();
               });
            });
         }
      }
      
      private function getItemNum(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Item = ItemManager.getItemByReferenceId(param1);
         if(_loc2_)
         {
            _loc3_ = int(_loc2_.quantity);
         }
         else
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function showNpc() : void
      {
         this.hideNpc();
         this._npc = new Mobile();
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPC_ID);
         this._npc.scaleX = -1;
         this._npc.x = this.POS[0];
         this._npc.y = this.POS[1];
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._mapModel.content.addChild(this._npc);
         this.showMouseHintAtMonster(this._npc);
         this._npc.addEventListener(MouseEvent.CLICK,this.onDialogShow);
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 50;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      public function hideNpc() : void
      {
         if(Boolean(this._npc) && Boolean(this._npc.parent))
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onDialogShow);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      public function removeUnit() : void
      {
         var _loc2_:BaseUnit = null;
         var _loc3_:String = null;
         var _loc1_:Vector.<String> = Vector.<String>(["电池购买","地幔层规则","进入地核层","岩石阵挑战开始"," 熔浆阵挑战开始","对流阵挑战开始"]);
         for each(_loc3_ in _loc1_)
         {
            _loc2_ = DialogPanel.functionalityBox.getUnit(_loc3_);
            if(_loc2_)
            {
               DialogPanel.functionalityBox.removeUnit(_loc2_);
            }
         }
      }
      
      public function dispose() : void
      {
         this._mapModel = null;
         this._resLib = null;
         if(this._curHandle)
         {
            this._curHandle.dispose();
            this._curHandle = null;
         }
         DialogPanel.functionalityBox.clear();
         DisplayUtil.removeForParent(this._npc);
         this._npc = null;
         this._self = null;
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUint);
      }
   }
}
