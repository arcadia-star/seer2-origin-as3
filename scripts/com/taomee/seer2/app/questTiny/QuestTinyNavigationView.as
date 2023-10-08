package com.taomee.seer2.app.questTiny
{
   import com.taomee.seer2.app.component.Scroller;
   import com.taomee.seer2.app.component.tree.TreeItem;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.questTiny.items.QuestTinyNavigationItem;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class QuestTinyNavigationView extends Sprite
   {
      
      private static const ITEM_HEIGHT_TOTAL:int = 181;
       
      
      private var _mainView:MovieClip;
      
      private var _scroller:Scroller;
      
      private var _categoryBtns:Vector.<SimpleButton>;
      
      private var _navigationItems:Vector.<TreeItem>;
      
      private var _itemRect:Rectangle;
      
      private const typeArr:Array = [QuestTinyHelper.RECOMMEND_QUEST,QuestTinyHelper.MAIN_QUEST,QuestTinyHelper.STAR_QUEST];
      
      private var _curTab:int = -1;
      
      public function QuestTinyNavigationView(param1:MovieClip)
      {
         super();
         this._mainView = param1;
         addChild(this._mainView);
         this.setupCategoryItem();
         this.createNavigationItem();
         this.createScroller();
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestRefresh);
         QuestManager.addEventListener(QuestEvent.INIT,this.onQuestRefresh);
         QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onQuestRefresh);
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestRefresh);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onQuestRefresh);
      }
      
      private function get curTab() : int
      {
         return this._curTab;
      }
      
      private function set curTab(param1:int) : void
      {
         if(this.curTab == param1)
         {
            return;
         }
         if(this.curTab != -1)
         {
            this._navigationItems[this.curTab].showChildren = false;
         }
         this._navigationItems[param1].showChildren = true;
         this._curTab = param1;
      }
      
      private function refreshStarQuest(param1:Event) : void
      {
         QuestTinyHelper.updateChildren(this._navigationItems[2],this.typeArr[2]);
      }
      
      private function refreshQuestShow() : void
      {
         QuestTinyHelper.updateChildren(this._navigationItems[0],this.typeArr[0]);
         QuestTinyHelper.updateChildren(this._navigationItems[1],this.typeArr[1]);
      }
      
      private function onQuestRefresh(param1:QuestEvent) : void
      {
         if(this.curTab == -1)
         {
            this.curTab = 0;
         }
         this.refreshQuestShow();
      }
      
      private function setupCategoryItem() : void
      {
         this._categoryBtns = new Vector.<SimpleButton>();
         var _loc1_:int = 0;
         while(_loc1_ < this.typeArr.length)
         {
            this._categoryBtns.push(this._mainView["tab" + _loc1_]);
            this._categoryBtns[_loc1_].addEventListener(MouseEvent.CLICK,this.onCategory);
            _loc1_++;
         }
      }
      
      protected function onCategory(param1:MouseEvent) : void
      {
         this.curTab = this._categoryBtns.indexOf(param1.currentTarget);
      }
      
      private function createNavigationItem() : void
      {
         this._navigationItems = new Vector.<TreeItem>();
         var _loc1_:int = 0;
         while(_loc1_ < this.typeArr.length)
         {
            this._navigationItems.push(new QuestTinyNavigationItem());
            this._navigationItems[_loc1_].y = 30;
            this._mainView.addChild(this._navigationItems[_loc1_]);
            this._navigationItems[_loc1_].showChildren = false;
            this._navigationItems[_loc1_].addEventListener(TreeItem.LAYOUT_COMPLETE,this.onLayoutComplete);
            _loc1_++;
         }
         this._itemRect = new Rectangle(0,30,213,ITEM_HEIGHT_TOTAL);
         this._navigationItems[0].scrollRect = this._itemRect;
         this.refreshQuestShow();
         this.refreshStarQuest(null);
         this.curTab = 0;
      }
      
      private function createScroller() : void
      {
         var _loc1_:MovieClip = this._mainView["scroller"];
         this._scroller = new Scroller(_loc1_);
         this._scroller.x = _loc1_.x;
         this._scroller.y = _loc1_.y;
         this._mainView.removeChild(_loc1_);
         this._mainView.addChild(this._scroller);
         this._scroller.addEventListener(Scroller.MOVE,this.onScrollerMove);
      }
      
      private function onLayoutComplete(param1:Event) : void
      {
         var _loc2_:Number = this._scroller.scrollPosition / (this._scroller.maxScrollPosition - this._scroller.pageSize);
         this._scroller.pageSize = ITEM_HEIGHT_TOTAL;
         this._scroller.maxScrollPosition = this._navigationItems[this.curTab].mesuredHeight;
         if(this._scroller.maxScrollPosition <= this._scroller.pageSize)
         {
            this._scroller.scrollPosition = 0;
         }
         else
         {
            this._scroller.scrollPosition = (this._scroller.maxScrollPosition - this._scroller.pageSize) * _loc2_;
         }
         this.onScrollerMove(null);
      }
      
      private function onScrollerMove(param1:Event) : void
      {
         this._itemRect.y = this._scroller.scrollPosition;
         this._navigationItems[this.curTab].scrollRect = this._itemRect;
      }
      
      public function update() : void
      {
         this._navigationItems[this.curTab].update(null);
         this._scroller.scrollPosition = 0;
         this.onScrollerMove(null);
      }
      
      public function open() : void
      {
         this._mainView.visible = true;
      }
      
      public function close() : void
      {
         this._mainView.visible = false;
      }
      
      public function moveOut() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._categoryBtns[_loc1_].alpha = 0.5;
            _loc1_++;
         }
         this._mainView["background"].alpha = 0.05;
      }
      
      public function moveIn() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._categoryBtns[_loc1_].alpha = 1;
            _loc1_++;
         }
         this._mainView["background"].alpha = 1;
      }
   }
}
