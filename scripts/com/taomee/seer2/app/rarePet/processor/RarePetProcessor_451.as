package com.taomee.seer2.app.rarePet.processor
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.utils.IDataInput;
   
   public class RarePetProcessor_451 extends BaseRarePetProcessor
   {
       
      
      public function RarePetProcessor_451(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.active.mapID == _mapId)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
            OnlyFlagManager.RequestFlag(function():void
            {
               var _loc1_:int = OnlyFlagManager.getFlag(271);
               if(_loc1_ == 1)
               {
                  hideNPC();
               }
               else
               {
                  showNPC();
               }
            });
         }
      }
      
      private function onCustomUnitClick(param1:DialogPanelEvent) : void
      {
         var evt:DialogPanelEvent = param1;
         if(evt.content.params == "DreamTrue")
         {
            NpcDialog.show(451,"受伤的小乔",[[0,"我的哥哥们每个人都有一些祝福粉末，你在晚上遇到他们的话一定可以拿到一些作为谢礼！每天下午14:00-15:00我们的大哥还会出来接受挑战哦！"]],["我知道了"],[function():void
            {
               ItemManager.requestItemList(function():void
               {
                  var cnt:* = 100 - ItemManager.getItemQuantityByReferenceId(400224);
                  if(cnt <= 0)
                  {
                     SwapManager.swapItem(193,1,function(param1:IDataInput):void
                     {
                        var _loc2_:* = new SwapInfo(param1);
                        OnlyFlagManager.updataFlag(193,1);
                        NpcDialog.show(451,"受伤的小乔",[[0,"终于！我可以自己出去冒险了！从今天起你就是我的主人了！"]],["我知道了"]);
                        MovieClipUtil.playFullScreen("res/active/fullScreen/christmasAni.swf");
                        hideNPC();
                     });
                  }
                  else
                  {
                     NpcDialog.show(451,"受伤的小乔",[[0,"你好像还差" + cnt + "个祝福粉末哦，我已经等不及要进化了！"]],["我知道了"]);
                  }
               });
            }]);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onCustomUnitClick);
         super.processMapDispose();
      }
   }
}
