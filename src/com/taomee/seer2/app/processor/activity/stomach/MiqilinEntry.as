package com.taomee.seer2.app.processor.activity.stomach
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.net.parser.Parser_1224;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MiqilinEntry
   {
      
      private static var isPlayAnimation:Boolean = false;
       
      
      private var _map:MapModel;
      
      private var _eggBtn:SimpleButton;
      
      public function MiqilinEntry(param1:MapModel)
      {
         super();
         this._map = param1;
         this.init();
         this.initAnimation();
      }
      
      private function init() : void
      {
         this._eggBtn = this._map.content["eggBtn"];
         this._eggBtn.addEventListener(MouseEvent.CLICK,this.toBuyEgg);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onNpc);
      }
      
      private function toBuyEgg(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = new BuyPropInfo();
         _loc2_.itemId = 801012;
         _loc2_.buyComplete = this.buyComplete;
         ShopManager.buyVirtualItem(_loc2_);
      }
      
      private function buyComplete(param1:Parser_1224) : void
      {
         AlertManager.showAlert("恭喜你购买成功！");
      }
      
      private function initAnimation() : void
      {
         if(QuestManager.isComplete(10042) == false)
         {
            Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
            Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
            Connection.send(CommandSet.ACTIVE_COUNT_1142,1,202225);
         }
      }
      
      private function onGetActiveCount(param1:MessageEvent) : void
      {
         var parser:Parser_1142;
         var url:String = null;
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         parser = new Parser_1142(event.message.getRawData());
         if(parser.infoVec[0] == 0)
         {
            url = String(URLUtil.getActivityAnimation("10/3"));
            SwapManager.swapItem(211,1,function():void
            {
            });
            MovieClipUtil.playFullScreen(url);
         }
      }
      
      private function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
      }
      
      private function onNpc(param1:DialogPanelEvent) : void
      {
         var url:String = null;
         var event:DialogPanelEvent = param1;
         if(event.content.params == "miqilin1")
         {
            if(isPlayAnimation)
            {
               if(FightVerifyManager.validateFightStart())
               {
                  SwapManager.swapItem(210,1,function():void
                  {
                     FightManager.startFightWithWild(10003);
                  },function(param1:int):void
                  {
                     if(param1 == 6)
                     {
                        AlertManager.showAlert("你还没有特别的羽毛来弱化米奇林大王");
                     }
                  });
               }
            }
            else if(FightVerifyManager.validateFightStart())
            {
               SwapManager.swapItem(210,1,function():void
               {
                  isPlayAnimation = true;
                  url = URLUtil.getActivityAnimation("10/1");
                  MovieClipUtil.playFullScreen(url,function():void
                  {
                     FightManager.startFightWithWild(10003);
                  });
               },function(param1:int):void
               {
                  if(param1 == 6)
                  {
                     AlertManager.showAlert("你还没有特别的羽毛来弱化米奇林大王");
                  }
               });
            }
         }
         else if(event.content.params == "miqilin2")
         {
            url = String(URLUtil.getActivityAnimation("10/2"));
            MovieClipUtil.playFullScreen(url,function():void
            {
               FightManager.startFightWithWild(10004);
            });
         }
      }
      
      public function dispose() : void
      {
         this._eggBtn.removeEventListener(MouseEvent.CLICK,this.toBuyEgg);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onNpc);
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
      }
   }
}
