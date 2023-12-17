package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class FashionPetAct
   {
      
      private static var _instance:FashionPetAct;
       
      
      private var npc:Mobile;
      
      public function FashionPetAct()
      {
         super();
      }
      
      public static function getInstance() : FashionPetAct
      {
         if(!_instance)
         {
            _instance = new FashionPetAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(SceneManager.active.type == SceneType.PLANT && SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            this.createNpc();
         }
      }
      
      public function dispose() : void
      {
         this.npc.removeEventListener(MouseEvent.CLICK,this.showPanel);
      }
      
      private function createNpc() : void
      {
         if(!this.npc)
         {
            this.npc = new Mobile();
         }
         this.npc.buttonMode = true;
         this.npc.resourceUrl = URLUtil.getNpcSwf(618);
         this.npc.x = 570;
         this.npc.y = 360;
         MobileManager.addMobile(this.npc,MobileType.NPC);
         this.npc.addEventListener(MouseEvent.CLICK,this.showPanel);
      }
      
      private function showPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("FashionPetPanel"));
      }
   }
}
