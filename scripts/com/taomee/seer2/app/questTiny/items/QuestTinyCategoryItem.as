package com.taomee.seer2.app.questTiny.items
{
   import com.taomee.seer2.app.component.tree.TreeItem;
   import com.taomee.seer2.app.questTiny.QuestTinyHelper;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestTinyCategoryItem extends TreeItem
   {
      
      private static var _instanceVec:Vector.<com.taomee.seer2.app.questTiny.items.QuestTinyCategoryItem> = new Vector.<com.taomee.seer2.app.questTiny.items.QuestTinyCategoryItem>();
       
      
      private var _type:String;
      
      private var _mainUI:MovieClip;
      
      private var _flagMc:MovieClip;
      
      public function QuestTinyCategoryItem()
      {
         this._mainUI = UIManager.getMovieClip("QuestTinyCategoryItemUI");
         this._mainUI.gotoAndStop(1);
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
         super(this._mainUI);
         addInstance(this);
      }
      
      private static function addInstance(param1:com.taomee.seer2.app.questTiny.items.QuestTinyCategoryItem) : void
      {
         _instanceVec.push(param1);
      }
      
      private static function updateInstance(param1:com.taomee.seer2.app.questTiny.items.QuestTinyCategoryItem) : void
      {
         var _loc2_:com.taomee.seer2.app.questTiny.items.QuestTinyCategoryItem = null;
         for each(_loc2_ in _instanceVec)
         {
            if(_loc2_ != param1)
            {
               _loc2_.showChildren = false;
            }
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.showChildren = !showChildren;
         updateInstance(this);
         this.dispatchClickEvent();
      }
      
      internal function dispatchClickEvent() : void
      {
      }
      
      override public function update(param1:*) : void
      {
         this._type = param1;
         switch(this._type)
         {
            case QuestTinyHelper.RECOMMEND_QUEST:
               this._mainUI.gotoAndStop(1);
               break;
            case QuestTinyHelper.MAIN_QUEST:
               this._mainUI.gotoAndStop(2);
               break;
            case QuestTinyHelper.ACTIVITY_QUEST:
               this._mainUI.gotoAndStop(3);
         }
      }
      
      override public function set showChildren(param1:Boolean) : void
      {
         super.showChildren = param1;
         this.updateChildren();
         this._flagMc.gotoAndStop(showChildren ? 2 : 1);
      }
      
      override public function get data() : *
      {
         return this._type;
      }
      
      private function updateChildren() : void
      {
         if(showChildren)
         {
            switch(this._type)
            {
               case QuestTinyHelper.RECOMMEND_QUEST:
               case QuestTinyHelper.PET_QUEST:
                  QuestTinyHelper.updateChildren(this,this._type);
                  break;
               case QuestTinyHelper.MAIN_QUEST:
                  QuestTinyHelper.updateChildren(this,this._type);
                  break;
               case QuestTinyHelper.ACTIVITY_QUEST:
                  QuestTinyHelper.updateChildren(this,this._type);
                  break;
               case QuestTinyHelper.BRANCH_QUEST:
                  QuestTinyHelper.updateChildren(this,this._type);
            }
         }
      }
      
      override public function dispose() : void
      {
         this._mainUI.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.dispose();
      }
   }
}
