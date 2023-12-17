package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80065 extends MapProcessor
   {
      
      private static const RANDOM_ID:int = 65;
      
      private static const RANDOM_FOR:uint = 203359;
      
      private static const ITEM_ID:uint = 400363;
      
      private static const USE_SWAP:int = 2084;
       
      
      private var _holeList:Vector.<MovieClip>;
      
      public function MapProcessor_80065(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.zombieDrActInit();
      }
      
      private function zombieDrActInit() : void
      {
         var _loc1_:int = 0;
         this._holeList = new Vector.<MovieClip>();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this._holeList.push(_map.content["hole" + _loc1_]);
            this._holeList[_loc1_].buttonMode = true;
            this._holeList[_loc1_].addEventListener(MouseEvent.CLICK,this.onHoleRandom);
            _loc1_++;
         }
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         Connection.addErrorHandler(CommandSet.RANDOM_EVENT_1140,this.onError);
         ModuleManager.showModule(URLUtil.getAppModule("ZombieDrSelectDoorPanel"),"正在打开僵尸博士通缉令面板...");
      }
      
      private function onError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 200028)
         {
            AlertManager.showAlert("今天追击的次数已用完，明天再来吧!");
         }
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
         if(_loc2_.index == RANDOM_ID)
         {
            if(_loc2_.id == 1)
            {
               SceneManager.changeScene(SceneType.COPY,80064);
            }
            else if(_loc2_.id == 2)
            {
               ModuleManager.showModule(URLUtil.getAppModule("ZombieDrNormalPanel"),"正在打开普通僵尸面板...");
            }
         }
      }
      
      private function setHoleBtnEnable(param1:Boolean) : void
      {
         if(!this._holeList)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._holeList.length)
         {
            this._holeList[_loc2_].mouseEnabled = this._holeList[_loc2_].mouseChildren = param1;
            _loc2_++;
         }
      }
      
      private function onHoleRandom(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.setHoleBtnEnable(false);
         StatisticsManager.sendNovice("0x10034207");
         ActiveCountManager.requestActiveCount(RANDOM_FOR,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var val:uint = param2;
            switch(val)
            {
               case 0:
                  ItemManager.requestItemList(function():void
                  {
                     if(ItemManager.getItemQuantityByReferenceId(ITEM_ID) > 0)
                     {
                        SwapManager.swapItem(USE_SWAP,1,function(param1:IDataInput):void
                        {
                           Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_ID,0);
                           setHoleBtnEnable(true);
                        },function(param1:uint):void
                        {
                           Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_ID,0);
                           setHoleBtnEnable(true);
                        });
                     }
                     else
                     {
                        Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_ID,0);
                        setHoleBtnEnable(true);
                     }
                  });
                  break;
               case 1:
                  setHoleBtnEnable(true);
                  SceneManager.changeScene(SceneType.COPY,80064);
                  break;
               case 2:
                  ModuleManager.showModule(URLUtil.getAppModule("ZombieDrNormalPanel"),"正在打开遇到普通boss面板...");
                  setHoleBtnEnable(true);
            }
         });
      }
      
      private function zombieDrActDispose() : void
      {
         var _loc1_:int = 0;
         if(this._holeList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._holeList.length)
            {
               this._holeList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onHoleRandom);
               _loc1_++;
            }
            this._holeList = null;
         }
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         Connection.removeErrorHandler(CommandSet.RANDOM_EVENT_1140,this.onError);
      }
      
      override public function dispose() : void
      {
         this.zombieDrActDispose();
         super.dispose();
      }
   }
}
