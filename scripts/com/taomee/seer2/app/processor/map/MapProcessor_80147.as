package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80147 extends MapProcessor
   {
      
      private static const RANDOM_SWAP:int = 2429;
      
      private static const RANDOM_FOR:uint = 203793;
       
      
      private var _holeList:Vector.<MovieClip>;
      
      public function MapProcessor_80147(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.musiActInit();
      }
      
      private function musiActInit() : void
      {
         this._holeList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._holeList.push(_map.content["hole" + _loc1_]);
            this._holeList[_loc1_].buttonMode = true;
            this._holeList[_loc1_].addEventListener(MouseEvent.CLICK,this.onHoleRandom);
            _loc1_++;
         }
         ModuleManager.showModule(URLUtil.getAppModule("MiuSiSelectDoorPanel"),"正在打开面板...");
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
         StatisticsManager.sendNovice("0x100345C7");
         this.setHoleBtnEnable(false);
         ActiveCountManager.requestActiveCount(RANDOM_FOR,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var val:uint = param2;
            switch(val)
            {
               case 0:
                  SwapManager.swapItem(RANDOM_SWAP,1,function(param1:IDataInput):void
                  {
                     var data:IDataInput = param1;
                     new SwapInfo(data);
                     ActiveCountManager.requestActiveCount(RANDOM_FOR,function(param1:uint, param2:uint):void
                     {
                        switch(param2)
                        {
                           case 1:
                              ModuleManager.showModule(URLUtil.getAppModule("MiuSiNormalPanel"),"正在打开遇到普通boss面板...");
                              setHoleBtnEnable(true);
                              break;
                           case 2:
                              setHoleBtnEnable(true);
                              SceneManager.changeScene(SceneType.COPY,80148);
                        }
                     });
                  },function(param1:uint):void
                  {
                     AlertManager.showAlert("选择星团的次数已用完。");
                  });
                  break;
               case 1:
                  ModuleManager.showModule(URLUtil.getAppModule("MiuSiNormalPanel"),"正在打开遇到普通boss面板...");
                  setHoleBtnEnable(true);
                  break;
               case 2:
                  setHoleBtnEnable(true);
                  SceneManager.changeScene(SceneType.COPY,80148);
                  break;
               case 3:
                  setHoleBtnEnable(true);
                  SceneManager.changeScene(SceneType.COPY,80148);
            }
         });
      }
      
      private function muSiActDispose() : void
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
      }
      
      override public function dispose() : void
      {
         this.muSiActDispose();
         super.dispose();
      }
   }
}
