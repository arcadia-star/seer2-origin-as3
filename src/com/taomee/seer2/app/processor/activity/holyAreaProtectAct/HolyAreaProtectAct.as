package com.taomee.seer2.app.processor.activity.holyAreaProtectAct
{
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class HolyAreaProtectAct
   {
      
      private static const DAY_LIST:Vector.<int> = Vector.<int>([929,930,931,932,933]);
      
      private static const GET_SWAP:int = 2256;
      
      private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([678,682]);
       
      
      private var _mapModel:MapModel;
      
      private var _clickResList:Vector.<MovieClip>;
      
      private var _npc:Mobile;
      
      private var _npc1:Mobile;
      
      public function HolyAreaProtectAct(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         this._clickResList = new Vector.<MovieClip>();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this._clickResList.push(this._mapModel.content["getAnimation" + _loc1_]);
            this._clickResList[_loc1_].buttonMode = true;
            this._clickResList[_loc1_].addEventListener(MouseEvent.CLICK,this.onClickRes);
            _loc1_++;
         }
         this._npc = MobileManager.getMobile(NPC_ID_LIST[0],MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         this._npc1 = MobileManager.getMobile(NPC_ID_LIST[1],MobileType.NPC);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("HolyAreaProtectPanel"),"正在打开神域守门人面板...");
      }
      
      private function onClickRes(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         index = this._clickResList.indexOf(evt.currentTarget as MovieClip);
         this.setClickBtnEnable(false);
         DayLimitManager.getDoCount(DAY_LIST[index],function(param1:int):void
         {
            var val:int = param1;
            if(val > 0)
            {
               AlertManager.showAlert("你今天领取过了，到别的地方看看吧!");
               setClickBtnEnable(true);
            }
            else
            {
               SwapManager.swapItem(GET_SWAP,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  setClickBtnEnable(true);
               },function(param1:uint):void
               {
                  setClickBtnEnable(true);
               },new SpecialInfo(1,index));
            }
         });
      }
      
      private function setClickBtnEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._clickResList.length)
         {
            this._clickResList[_loc2_].mouseEnabled = this._clickResList[_loc2_].mouseChildren = param1;
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(this._clickResList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._clickResList.length)
            {
               this._clickResList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onClickRes);
               _loc1_++;
            }
            this._clickResList = null;
         }
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
            this._npc = null;
         }
         this._mapModel = null;
      }
   }
}
