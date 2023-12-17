package com.taomee.seer2.app.rightToolbar.toolbar
{
   import com.taomee.seer2.app.dream.DreamManager;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbar;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class NewPlayerToolbar extends RightToolbar
   {
       
      
      private var _effect:MovieClip;
      
      public function NewPlayerToolbar()
      {
         super();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(NewPlayerGuideTimeManager.timeCheckNewGuide())
         {
            SceneManager.changeScene(SceneType.COPY,80491);
         }
         else
         {
            SceneManager.changeScene(SceneType.COPY,80351);
         }
      }
      
      override public function update() : void
      {
         if(this.isFightHomeIng() == false)
         {
            return;
         }
         if(_btn)
         {
            this.show();
         }
         else
         {
            QueueLoader.load(URLUtil.getRes("loaderLibrary/rightToolbar/" + _info.sort + ".swf"),LoadType.SWF,onResLoaded);
         }
      }
      
      override protected function show() : void
      {
         super.show();
         if(!NewPlayerGuideTimeManager.timeCheckNewGuide())
         {
            DisplayObjectUtil.removeFromParent(this._effect);
         }
         else if(!QuestManager.isComplete(99))
         {
            if(SceneManager.active && SceneManager.currentSceneType != SceneType.ARENA && SceneManager.active.mapID != 80491)
            {
               this.setEffectVisible(true);
            }
            else
            {
               this.setEffectVisible(false);
            }
         }
      }
      
      private function setEffectVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(this._effect == null)
            {
               this._effect = UIManager.getMovieClip("RightToorEffect");
               this._effect.mouseEnabled = this._effect.mouseChildren = false;
            }
            this._effect.x = -10;
            this._effect.y = 20;
            addChild(this._effect);
         }
         else if(this._effect)
         {
            DisplayObjectUtil.removeFromParent(this._effect);
         }
      }
      
      private function isFightHomeIng() : Boolean
      {
         if(SceneManager.active == null)
         {
            return false;
         }
         if(SceneManager.active.type == SceneType.ARENA || SceneManager.active.type == SceneType.TEAM || SceneManager.active.type == SceneType.GUDIE_ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA2 || SceneManager.active.type == SceneType.GUDIE_ARENA3 || SceneManager.active.type == SceneType.GUDIE_ARENA4 || SceneManager.active.type == SceneType.GUDIE_ARENA5 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA1 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA2 || SceneManager.active.type == SceneType.GUIDE_NEW_ARENA3)
         {
            return false;
         }
         if(Boolean(SceneManager.active) && DreamManager.isDreamMap())
         {
            return false;
         }
         if(SceneManager.active.type == SceneType.HOME)
         {
            return false;
         }
         return true;
      }
      
      override public function remove() : void
      {
         super.remove();
         this.setEffectVisible(false);
      }
   }
}
