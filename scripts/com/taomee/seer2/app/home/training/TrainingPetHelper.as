package com.taomee.seer2.app.home.training
{
   import com.taomee.seer2.app.home.data.TrainingPetInfo;
   import flash.geom.Point;
   
   public class TrainingPetHelper
   {
      
      private static const PET_POS_ARR:Array = [[637,350],[740,340],[650,410],[710,390],[710,455],[760,400],[830,440],[590,470],[470,460]];
      
      private static const PET_WORD_ARR:Array = ["既然来了，就和我对战一场吧","我可不是那种懦弱的精灵！","在这里战斗的话经验可是很多的哦。","可不是我吹牛，最近已经有很多精灵败在我手上了哦。","为什么我就找不到任何对手呢！","我只是想好好锻炼一下，别来理我！","低调，低调～","我不是好欺负的哦，敢和我单挑吗？","你好像也不过如此嘛","其实锻炼是有诀窍，我可以慢慢教给你哦……"];
      
      private static var _handler:com.taomee.seer2.app.home.training.TrainingPetSceneHandler;
      
      private static var _positionUsedArr:Array;
       
      
      public function TrainingPetHelper()
      {
         super();
      }
      
      public static function reset(param1:com.taomee.seer2.app.home.training.TrainingPetSceneHandler) : void
      {
         _handler = param1;
         _positionUsedArr = [];
         var _loc2_:int = 0;
         while(_loc2_ < PET_POS_ARR.length)
         {
            _positionUsedArr.push(false);
            _loc2_++;
         }
      }
      
      public static function getPetSloganVec() : Vector.<String>
      {
         return Vector.<String>(PET_WORD_ARR);
      }
      
      public static function getPetPostion() : Point
      {
         var _loc1_:int = 0;
         do
         {
            _loc1_ = Math.floor(Math.random() * PET_POS_ARR.length);
         }
         while(_positionUsedArr[_loc1_]);
         
         _positionUsedArr[_loc1_] = true;
         return new Point(PET_POS_ARR[_loc1_][0],PET_POS_ARR[_loc1_][1]);
      }
      
      public static function returnPetPostion(param1:Point) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < PET_POS_ARR.length)
         {
            if(PET_POS_ARR[_loc2_][0] == param1.x && PET_POS_ARR[_loc2_][1] == param1.y)
            {
               _positionUsedArr[_loc2_] = false;
               break;
            }
            _loc2_++;
         }
      }
      
      public static function addTrainingPet(param1:TrainingPetInfo) : void
      {
         _handler.addTrainingPet(param1);
      }
      
      public static function removeTrainingPet(param1:uint) : void
      {
         _handler.removeTrainingPet(param1);
      }
   }
}
