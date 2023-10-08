package com.taomee.seer2.app.dialog.functionality
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.events.MouseEvent;
   
   public class CustomUnit extends BaseUnit
   {
       
      
      private var _customHandler:Function;
      
      public function CustomUnit(param1:String, param2:String, param3:String)
      {
         super();
         this.type = param1;
         this.label = param2;
         this.params = param3;
      }
      
      public function set customHandler(param1:Function) : void
      {
         this._customHandler = param1;
      }
      
      override protected function addIcon() : void
      {
         _icon = UIManager.getSprite("UI_DialogReward");
         addChild(_icon);
      }
      
      override protected function onBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.type == "gotoMap")
         {
            _loc2_ = int(uint(params));
            if(_loc2_ < 80000)
            {
               SceneManager.changeScene(SceneType.LOBBY,_loc2_);
            }
            else
            {
               SceneManager.changeScene(SceneType.COPY,_loc2_);
            }
            DialogPanel.hide();
            return;
         }
         dispatchEvent(new FunctionalityBoxEvent(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,new DialogPanelEventData(type,params),true));
         if(this._customHandler != null)
         {
            this._customHandler();
            this._customHandler = null;
         }
      }
   }
}
