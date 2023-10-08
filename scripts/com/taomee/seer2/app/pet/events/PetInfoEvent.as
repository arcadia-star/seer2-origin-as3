package com.taomee.seer2.app.pet.events
{
   import com.taomee.seer2.app.pet.data.PetInfo;
   import flash.events.Event;
   
   public class PetInfoEvent extends Event
   {
      
      public static const PET_ADD:String = "petAdd";
      
      public static const PET_REMOVE:String = "petRemove";
      
      public static const PET_CURE:String = "petCure";
      
      public static const PET_PROPERTIES_CHANGE:String = "petPropertiesChange";
      
      public static const PET_FIGHT_ITEM:String = "petFightItem";
      
      public static const PET_CHANGE_STARTING:String = "petChangeStart";
      
      public static const PET_CHANGE_SUB:String = "petChangeSub";
      
      public static const PET_SET_FOLLOW:String = "petSetFollow";
      
      public static const PET_START_TRAINING:String = "petStartTraining";
      
      public static const PET_PUT_TO_BAG:String = "petPutToBag";
      
      public static const PET_PUT_TO_BAG_STORAGE:String = "petPutToBagStorage";
      
      public static const PET_PUT_TO_STORAGE:String = "petPutToStorage";
      
      public static const PET_FLAG_CHANGE:String = "petFlagChange";
      
      public static const SERVER_GET_PET:String = "serverGetPet";
      
      public static const PET_EXPERENCE_CHANGE:String = "petExperenceChange";
      
      public static const HOOK_PET_EXPERENCE_CHANGE:String = "hookPetExperenceChange";
      
      public static const PET_LEVEL_UP:String = "petLevelUp";
      
      public static const PET_DECORATION_UP:String = "petDecorationUp";
      
      public static const PET_SET_RIDE:String = "PET_SET_RIDE";
      
      public static const PET_STORAGE_ADD:String = "petStorageAdd";
      
      public static const PET_BAG_STORAGE_CHANGE:String = "petBagStorageChange";
      
      public static const PET_STORAGE_REMOVE:String = "petStorageRemove";
       
      
      private var _info:PetInfo;
      
      private var _content;
      
      public function PetInfoEvent(param1:String, param2:PetInfo, param3:* = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._info = param2;
         this._content = param3;
      }
      
      public function get info() : PetInfo
      {
         return this._info;
      }
      
      public function get content() : *
      {
         return this._content;
      }
   }
}
