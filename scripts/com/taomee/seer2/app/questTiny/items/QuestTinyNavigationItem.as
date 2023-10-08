package com.taomee.seer2.app.questTiny.items
{
   import com.taomee.seer2.app.component.tree.TreeItem;
   import flash.display.Sprite;
   
   public class QuestTinyNavigationItem extends TreeItem
   {
       
      
      public function QuestTinyNavigationItem()
      {
         super(new Sprite());
         showChildren = true;
      }
      
      override public function update(param1:*) : void
      {
         this.updateChildren(param1);
      }
      
      private function updateChildren(param1:String) : void
      {
      }
   }
}
