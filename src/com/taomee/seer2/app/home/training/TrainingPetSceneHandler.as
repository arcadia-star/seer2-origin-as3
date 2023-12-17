package com.taomee.seer2.app.home.training
{
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.app.home.data.HomeInfo;
   import com.taomee.seer2.app.home.data.TrainingPetInfo;
   import com.taomee.seer2.app.pet.TrainingPet;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.scene.BaseScene;
   import com.taomee.seer2.core.scene.ISceneHandler;
   import flash.geom.Point;
   
   public class TrainingPetSceneHandler implements ISceneHandler
   {
       
      
      private var _scene:HomeScene;
      
      private var _homeInfo:HomeInfo;
      
      public function TrainingPetSceneHandler()
      {
         super();
      }
      
      public function init(param1:BaseScene) : void
      {
         this._scene = param1 as HomeScene;
      }
      
      public function onMapStart() : void
      {
         var _loc1_:TrainingPetInfo = null;
         TrainingPetHelper.reset(this);
         this._homeInfo = this._scene.homeInfo;
         for each(_loc1_ in this._homeInfo.trainingPetInfoVec)
         {
            this.addTrainingPetInternal(_loc1_);
         }
      }
      
      public function onTick(param1:int) : void
      {
      }
      
      public function onMapEnd() : void
      {
         this._homeInfo = null;
      }
      
      public function disopse() : void
      {
         this._scene = null;
      }
      
      public function addTrainingPet(param1:TrainingPetInfo) : void
      {
         this._homeInfo.addTrainingPetInfo(param1);
         this.addTrainingPetInternal(param1);
      }
      
      public function removeTrainingPet(param1:uint) : void
      {
         this._homeInfo.removeTrainingPetInfo(param1);
         this.removeTrainingPetInternal(param1);
      }
      
      private function addTrainingPetInternal(param1:TrainingPetInfo) : void
      {
         var _loc2_:Point = TrainingPetHelper.getPetPostion();
         var _loc3_:Vector.<String> = TrainingPetHelper.getPetSloganVec();
         var _loc4_:TrainingPet = new TrainingPet(param1,this._homeInfo.userInfo,_loc2_,_loc3_);
         MobileManager.addMobile(_loc4_,MobileType.TRAINING_PET);
      }
      
      private function removeTrainingPetInternal(param1:uint) : void
      {
         var _loc2_:TrainingPet = MobileManager.getMobile(param1,MobileType.TRAINING_PET) as TrainingPet;
         if(_loc2_)
         {
            TrainingPetHelper.returnPetPostion(_loc2_.position);
            MobileManager.removeMobileById(param1,MobileType.TRAINING_PET);
         }
      }
   }
}
