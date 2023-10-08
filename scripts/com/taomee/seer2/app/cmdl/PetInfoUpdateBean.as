package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   import org.taomee.bean.BaseBean;
   
   public class PetInfoUpdateBean extends BaseBean
   {
       
      
      private var _petItem_id:int;
      
      private var _petcCount:int;
      
      private var _newPet:PetInfo;
      
      private var _oldPet:PetInfo;
      
      private var _isAdd:Boolean;
      
      public function PetInfoUpdateBean()
      {
         super();
         Connection.addCommandListener(CommandSet.PET_INFO_MESSAGE_1216,this.onPetData);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         finish();
      }
      
      private function onPetData(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         this._petItem_id = _loc2_.readUnsignedInt();
         this._petcCount = _loc2_.readUnsignedInt();
         var _loc4_:PetInfo = new PetInfo();
         PetInfo.readPetInfo(_loc4_,_loc2_);
         this._newPet = _loc4_;
         this._oldPet = PetInfoManager.getFirstPetInfo();
         this._isAdd = true;
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex) && Boolean(FightManager.currentFightRecord.initData.type))
            {
               if(this._isAdd)
               {
                  this._isAdd = false;
                  AlertManager.showAlert("你的首发精灵【" + this._newPet.name + "】的资质提高到了" + this._petcCount.toString(),function():void
                  {
                     var _loc1_:Object = new Object();
                     _loc1_.oldPet = _oldPet;
                     _loc1_.newPet = _newPet;
                     ModuleManager.toggleModule(URLUtil.getAppModule("AppearResultPanel"),"正在加载资源...",_loc1_);
                  });
               }
            }
         }
      }
   }
}
