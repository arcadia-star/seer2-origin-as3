package com.taomee.seer2.app.firstTeach
{
   import com.taomee.seer2.app.controls.MapTitlePanel;
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.firstTeach.petSkillTeach.DiDiLanSkillTeach;
   import com.taomee.seer2.app.firstTeach.petSkillTeach.LaAoSkillTeach;
   import com.taomee.seer2.app.firstTeach.petSkillTeach.PetSkillTeachHelper;
   import com.taomee.seer2.app.firstTeach.petSkillTeach.XiuXiuSkillTeach;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import org.taomee.bean.BaseBean;
   
   public class FirstTeachManager extends BaseBean
   {
      
      private static var _statusVec:Vector.<int>;
      
      private static var _teacher:com.taomee.seer2.app.firstTeach.IFirstTeach;
      
      private static var _type:int;
      
      public static const PETSKILLTEACH_COMPLETE_EVENT:String = "petSkillTeachComplete";
      
      public static const PETSKILLTEACHHELPER_EVENT:String = "petSkillTeachHelperDispose";
      
      private static var _petSkillTeachHelper:PetSkillTeachHelper;
      
      private static var _petSkillTeachData:Object;
      
      private static var _callBack:Function;
       
      
      public function FirstTeachManager()
      {
         super();
      }
      
      private static function onMapStart(param1:SceneEvent) : void
      {
         if(_teacher)
         {
            _teacher.mapChange();
         }
      }
      
      private static function initPetSkillTeachHelper() : void
      {
         if(_petSkillTeachHelper == null)
         {
            _petSkillTeachHelper = new PetSkillTeachHelper();
            _petSkillTeachHelper.setStatus(_statusVec);
            _petSkillTeachHelper.initEventListener();
         }
      }
      
      private static function getStatusBuff(param1:Function = null) : void
      {
         _callBack = param1;
         ServerBufferManager.getServerBuffer(ServerBufferType.FIRSTTEACH,onGetStatus);
      }
      
      private static function onGetStatus(param1:ServerBuffer) : void
      {
         _statusVec = new Vector.<int>();
         var _loc2_:uint = param1.data.length < FirstTeachType.FIRST_TEACH_TOTAL_NUM ? uint(param1.data.length) : uint(FirstTeachType.FIRST_TEACH_TOTAL_NUM);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _statusVec.push(param1.readDataAtPostion(_loc3_));
            _loc3_++;
         }
         var _loc4_:int = int(_loc2_);
         while(_loc4_ < FirstTeachType.FIRST_TEACH_TOTAL_NUM)
         {
            _statusVec.push(0);
            _loc4_++;
         }
         if(_callBack != null)
         {
            _callBack();
            _callBack = null;
         }
      }
      
      public static function setPetSkillTeachData(param1:Object) : void
      {
         _petSkillTeachData = param1;
      }
      
      public static function firstTeach(param1:int) : void
      {
         if(QuestManager.isFreshQuestComplete())
         {
            _type = param1;
            if(_statusVec == null)
            {
               getStatusBuff(doTeach);
            }
            else
            {
               doTeach();
            }
         }
      }
      
      public static function updataStatus(param1:int, param2:int) : void
      {
         showTool();
         ServerBufferManager.updateServerBuffer(ServerBufferType.FIRSTTEACH,param1,param2);
         _statusVec[param1] = param2;
         _petSkillTeachHelper.setStatus(_statusVec);
         processReward(param1);
      }
      
      private static function processReward(param1:int) : void
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case FirstTeachType.SKILLTEACH_LA_AO:
            case FirstTeachType.SKILLTEACH_DIDILAN:
            case FirstTeachType.SKILLTEACH_XIUXIU:
               _loc2_ = (param1 - FirstTeachType.SKILLTEACH_LA_AO) * 3 + _petSkillTeachData.index + 48;
               requestReward(_loc2_);
         }
      }
      
      private static function requestReward(param1:uint) : void
      {
         SwapManager.swapItem(param1);
      }
      
      private static function doTeach() : void
      {
         initPetSkillTeachHelper();
         _petSkillTeachHelper.setStatus(_statusVec);
         processTeacher();
         if(_teacher)
         {
            hideTool();
            _teacher.teach();
         }
      }
      
      private static function processTeacher() : void
      {
         clearTeacher();
         switch(_type)
         {
            case FirstTeachType.SKILLTEACH_LA_AO:
               if(_statusVec[_type] != 3)
               {
                  _teacher = new LaAoSkillTeach(_petSkillTeachData);
               }
               break;
            case FirstTeachType.SKILLTEACH_DIDILAN:
               if(_statusVec[2] != 3)
               {
                  _teacher = new DiDiLanSkillTeach(_petSkillTeachData);
               }
               break;
            case FirstTeachType.SKILLTEACH_XIUXIU:
               if(_statusVec[2] != 4)
               {
                  _teacher = new XiuXiuSkillTeach(_petSkillTeachData);
               }
         }
      }
      
      private static function clearTeacher() : void
      {
         if(_teacher)
         {
            _teacher.dispose();
            _teacher = null;
         }
      }
      
      public static function getTeachStatus(param1:uint) : int
      {
         if(_statusVec == null)
         {
            return -1;
         }
         return _statusVec[param1];
      }
      
      public static function isShowInitPetPotential(param1:uint) : Boolean
      {
         return _petSkillTeachHelper.getInitPetPotentialStatus(param1);
      }
      
      public static function closePetSkillTeachPop() : void
      {
         _petSkillTeachHelper.closePop();
      }
      
      public static function dispose() : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,onMapStart);
         clearTeacher();
      }
      
      private static function hideTool() : void
      {
         MapTitlePanel.hide();
         PetAvatarPanel.hide();
         MinorToolBar.hide();
      }
      
      private static function showTool() : void
      {
         MapTitlePanel.show();
         PetAvatarPanel.show();
         MinorToolBar.show();
      }
      
      override public function start() : void
      {
         getStatusBuff(initPetSkillTeachHelper);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapStart);
         finish();
      }
   }
}
