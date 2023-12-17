package com.taomee.seer2.app.quest
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.QuestConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.inventory.utils.ItemCategoryUtil;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.ErrorMap;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.handler.main.quest112.QuestMapHandler_112_80575;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.QuestStep;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.data.QuestDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   import org.taomee.ds.HashMap;
   
   public class QuestManager
   {
      
      private static var _questMap:HashMap;
      
      private static var _dependenceMap:DependenceMap;
      
      private static var _isInit:Boolean = false;
      
      private static var _inProgressQuestIdVec:Vector.<int>;
      
      private static var _questBufferUpdateType:String;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function QuestManager()
      {
         super();
      }
      
      public static function setup(param1:Vector.<int>, param2:Vector.<int>, param3:Vector.<int>) : void
      {
         QuestNpcManager.setup();
         QuestProcessManager.setup();
         parseConfig();
         parseData(param1,param2,param3);
      }
      
      private static function parseConfig() : void
      {
         var _loc1_:QuestDefinition = null;
         var _loc2_:Quest = null;
         _questMap = new HashMap();
         for each(_loc1_ in QuestConfig.getAllDefinition())
         {
            _loc2_ = new Quest(_loc1_);
            _questMap.add(_loc2_.id,_loc2_);
            dependenceMap.addPreviousDepend(_loc1_.id,_loc1_.prerequisiteDefinition.preQuestIdVec);
         }
      }
      
      private static function parseData(param1:Vector.<int>, param2:Vector.<int>, param3:Vector.<int>) : void
      {
         var _loc4_:Quest = null;
         var _loc5_:int = 0;
         var _loc6_:int = int(param1.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = param1[_loc7_];
            getQuest(_loc5_).status = QuestStatus.COMPLETE;
            _loc7_++;
         }
         _loc6_ = int(param3.length);
         _inProgressQuestIdVec = param3;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = param3[_loc7_];
            if(!isQuestNew(_loc5_))
            {
               getQuest(_loc5_).status = QuestStatus.IN_PROGRESS;
            }
            _loc7_++;
         }
         _loc6_ = int(param2.length);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = param2[_loc7_];
            if(!isQuestNew(_loc5_))
            {
               getQuest(_loc5_).isLastComplete = true;
            }
            _loc7_++;
         }
         getQuestBufferServer(param3);
      }
      
      private static function init() : void
      {
         registerTarget();
         openNextQuests();
         _isInit = true;
         dispatchEvent(QuestEvent.INIT);
      }
      
      private static function registerTarget() : void
      {
         var _loc2_:Quest = null;
         var _loc4_:int = 0;
         var _loc5_:QuestStep = null;
         var _loc1_:uint = _inProgressQuestIdVec.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = _inProgressQuestIdVec[_loc3_];
            if(!isQuestNew(_loc4_))
            {
               _loc2_ = getQuest(_loc4_);
               _loc5_ = _loc2_.getCurrentOrNextStep();
               if(_loc2_.getCurrentOrNextStep().target != null)
               {
                  QuestTargetManager.initTarget(_loc2_);
               }
            }
            _loc3_++;
         }
      }
      
      public static function get isInit() : Boolean
      {
         return _isInit;
      }
      
      public static function openNextQuests() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         var _loc5_:Quest = null;
         var _loc1_:Vector.<int> = getQuestIdList(QuestStatus.COMPLETE);
         _loc1_.unshift(0);
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = _dependenceMap.completeDependent(_loc2_);
            for each(_loc4_ in _loc3_)
            {
               if((_loc5_ = getQuest(_loc4_)).status == QuestStatus.NONE && Boolean(_loc5_.verifyPrerequisite()))
               {
                  _loc5_.status = QuestStatus.ACCEPTABLE;
               }
            }
         }
      }
      
      public static function isCanAccepted(param1:int) : Boolean
      {
         var _loc2_:Quest = getQuest(param1);
         if(_loc2_)
         {
            return _loc2_.status == QuestStatus.ACCEPTABLE;
         }
         return false;
      }
      
      public static function isAccepted(param1:int) : Boolean
      {
         var _loc2_:Quest = getQuest(param1);
         if(_loc2_)
         {
            return _loc2_.status == QuestStatus.IN_PROGRESS;
         }
         return false;
      }
      
      public static function isCompletable(param1:int) : Boolean
      {
         var _loc2_:Quest = getQuest(param1);
         return _loc2_.isStepCompletable(_loc2_.getStepVec().length);
      }
      
      public static function isComplete(param1:int) : Boolean
      {
         var _loc2_:Quest = getQuest(param1);
         if(_loc2_)
         {
            return _loc2_.status == QuestStatus.COMPLETE;
         }
         return false;
      }
      
      public static function isCompleteList(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(getQuest(param1[_loc3_]).status == QuestStatus.COMPLETE)
            {
               _loc2_.push(true);
            }
            else
            {
               _loc2_.push(false);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function isFreshQuestComplete() : Boolean
      {
         return QuestManager.isComplete(1);
      }
      
      public static function isCompleteGudieTask() : Boolean
      {
         var _loc1_:Boolean = true;
         if(QuestManager.isComplete(68))
         {
            _loc1_ = true;
         }
         else if(QuestManager.isAccepted(31) || QuestManager.isComplete(31))
         {
            _loc1_ = true;
         }
         else if(QuestManager.isCanAccepted(53) || QuestManager.isAccepted(53))
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public static function isStepComplete(param1:int, param2:int) : Boolean
      {
         var _loc3_:Quest = null;
         if(isComplete(param1))
         {
            return true;
         }
         _loc3_ = getQuest(param1);
         if(Boolean(_loc3_) && _loc3_.status == QuestStatus.IN_PROGRESS)
         {
            return _loc3_.isStepCompete(param2);
         }
         return false;
      }
      
      public static function getQuestListByType(param1:int) : Vector.<Quest>
      {
         var _loc4_:Quest = null;
         var _loc2_:Vector.<Quest> = new Vector.<Quest>();
         var _loc3_:Array = _questMap.getValues();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.type == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public static function getQuestListByStatus(param1:int) : Vector.<Quest>
      {
         var _loc4_:Quest = null;
         var _loc2_:Vector.<Quest> = new Vector.<Quest>();
         var _loc3_:Array = _questMap.getValues();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.status == param1)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public static function getQuestList() : Vector.<Quest>
      {
         return Vector.<Quest>(_questMap.getValues());
      }
      
      public static function getQuestIdList(param1:int) : Vector.<int>
      {
         var _loc4_:Quest = null;
         var _loc2_:Vector.<Quest> = getQuestListByStatus(param1);
         var _loc3_:Vector.<int> = new Vector.<int>();
         for each(_loc4_ in _loc2_)
         {
            _loc3_.push(_loc4_.id);
         }
         return _loc3_;
      }
      
      public static function getQuest(param1:int) : Quest
      {
         return _questMap.getValue(param1) as Quest;
      }
      
      public static function acceptQuestLocal(param1:int) : void
      {
         var _loc2_:Quest = getQuest(param1);
         _loc2_.status = QuestStatus.IN_PROGRESS;
         _loc2_.setBuffer(null);
         if(_loc2_.getCurrentOrNextStep().target != null)
         {
            QuestTargetManager.initTarget(_loc2_);
         }
         dispatchEvent(QuestEvent.ACCEPT,param1);
      }
      
      private static function getQuestBufferServer(param1:Vector.<int>) : void
      {
         var _loc3_:LittleEndianByteArray = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(param1.length);
         if(_loc2_ > 0)
         {
            _loc3_ = new LittleEndianByteArray();
            _loc3_.writeUnsignedInt(_loc2_);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_.writeUnsignedInt(param1[_loc4_]);
               _loc4_++;
            }
            Connection.addCommandListener(CommandSet.QUEST_GET_BUFFER_1014,onGetQuestBuffer);
            Connection.send(CommandSet.QUEST_GET_BUFFER_1014,_loc3_);
         }
         else
         {
            init();
         }
      }
      
      private static function onGetQuestBuffer(param1:MessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:LittleEndianByteArray = null;
         Connection.removeCommandListener(CommandSet.QUEST_GET_BUFFER_1014,onGetQuestBuffer);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc6_ = new LittleEndianByteArray();
            _loc2_.readBytes(_loc6_,0,64);
            getQuest(_loc5_).setBuffer(_loc6_);
            _loc4_++;
         }
         init();
      }
      
      public static function accept(param1:int) : void
      {
         if(!isQuestNew(param1) && getQuest(param1).status != QuestStatus.ACCEPTABLE)
         {
            return;
         }
         Connection.addCommandListener(CommandSet.QUEST_ACCEPT_1011,onAcceptQuest);
         Connection.send(CommandSet.QUEST_ACCEPT_1011,param1);
      }
      
      private static function onAcceptQuest(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.QUEST_ACCEPT_1011,onAcceptQuest);
         var _loc2_:int = int(param1.message.getRawData().readUnsignedInt());
         acceptQuestLocal(_loc2_);
      }
      
      public static function abortQuest(param1:int) : void
      {
         if(!isQuestNew(param1) && getQuest(param1).status != QuestStatus.IN_PROGRESS)
         {
            return;
         }
         Connection.addCommandListener(CommandSet.QUEST_ABORT_1013,onAbortQuest);
         Connection.send(CommandSet.QUEST_ABORT_1013,param1);
      }
      
      private static function onAbortQuest(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.QUEST_ABORT_1013,onAbortQuest);
         var _loc2_:int = int(param1.message.getRawData().readUnsignedInt());
         getQuest(_loc2_).status = QuestStatus.ACCEPTABLE;
         dispatchEvent(QuestEvent.ABORT,_loc2_);
      }
      
      public static function completeStep(param1:int, param2:int) : void
      {
         var quest:Quest = null;
         var questId:int = param1;
         var stepId:int = param2;
         quest = getQuest(questId);
         if(quest.status == QuestStatus.IN_PROGRESS)
         {
            ItemManager.requestItemList(function():void
            {
               var id:int = 0;
               var data:LittleEndianByteArray = null;
               if(questId == 112 && Boolean(quest.isStepCompletable(stepId)))
               {
                  id = QuestMapHandler_112_80575._allRight ? 4611 : 4612;
                  SwapManager.swapItem(id,1,function success(param1:IDataInput):void
                  {
                     new SwapInfo(param1);
                  });
               }
               if(stepId == quest.getStepCount())
               {
                  if(isQuestStepOutComeMax(questId,stepId))
                  {
                     return;
                  }
               }
               if(questId == 1 || questId == 2 || Boolean(quest.isStepCompletable(stepId)))
               {
                  data = new LittleEndianByteArray();
                  data.writeUnsignedInt(questId);
                  data.writeByte(stepId);
                  data.writeBytes(quest.generateStepBuffer(stepId,true));
                  updateQuestBuffer(data,QuestBufferUpdateType.COMPLETE_OLD);
               }
            });
         }
      }
      
      private static function isQuestStepOutComeMax(param1:uint, param2:uint) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc3_:Quest = getQuest(param1);
         if(_loc3_.getStep(param2).outcome == null || _loc3_.getStep(param2).outcome.getReferenceIdVec() == null)
         {
            return false;
         }
         var _loc4_:uint = uint(_loc3_.getStep(param2).outcome.getReferenceIdVec().length);
         var _loc9_:uint = 0;
         while(_loc9_ < _loc4_)
         {
            _loc5_ = uint(_loc3_.getStep(param2).outcome.getReferenceIdVec()[_loc9_]);
            _loc7_ = Boolean(_loc3_.getStep(param2).outcome.getIsPetVec()[_loc9_]);
            _loc6_ = uint(_loc3_.getStep(param2).outcome.getQuantityVec()[_loc9_]);
            if(!(_loc5_ == 1 || _loc7_))
            {
               _loc8_ = uint(ItemConfig.getItemDefinition(_loc5_).quantityLimit);
               if(ItemManager.getItemQuantityByReferenceId(_loc5_) + _loc6_ > _loc8_)
               {
                  AlertManager.showItemMaxAlert(_loc5_);
                  return true;
               }
            }
            _loc9_++;
         }
         return false;
      }
      
      public static function setStepBufferServer(param1:int, param2:int) : void
      {
         var _loc4_:LittleEndianByteArray = null;
         var _loc3_:Quest = getQuest(param1);
         if(_loc3_.status == QuestStatus.IN_PROGRESS)
         {
            if(_loc3_.isStepCompletable(param2))
            {
               (_loc4_ = new LittleEndianByteArray()).writeUnsignedInt(param1);
               _loc4_.writeByte(param2);
               _loc4_.writeBytes(_loc3_.generateStepBuffer(param2,false));
               updateQuestBuffer(_loc4_,QuestBufferUpdateType.UPDATE_OLD);
            }
         }
      }
      
      public static function updateQuestBuffer(param1:LittleEndianByteArray, param2:String) : void
      {
         _questBufferUpdateType = param2;
         Connection.addCommandListener(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferSuc);
         Connection.addErrorHandler(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferErr);
         Connection.send(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,param1);
      }
      
      public static function listenerQuestBufferUpdate() : void
      {
         _questBufferUpdateType = QuestBufferUpdateType.COMPLETE_OLD;
         Connection.addCommandListener(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferSuc);
         Connection.addErrorHandler(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferErr);
      }
      
      public static function onUpdateQuestBufferSuc(param1:MessageEvent) : void
      {
         clearHandler1015();
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = int(_loc2_.readByte());
         parseOutput(_loc2_,_loc3_);
         switch(_questBufferUpdateType)
         {
            case QuestBufferUpdateType.COMPLETE_OLD:
               processCompleteOld(_loc3_,_loc4_);
               break;
            case QuestBufferUpdateType.UPDATE_OLD:
               processUpdateOld(_loc3_,_loc4_);
               break;
            case QuestBufferUpdateType.UPDATE_NEW:
               processUpdateNew(_loc3_,_loc4_);
         }
      }
      
      private static function processCompleteOld(param1:int, param2:int) : void
      {
         var _loc5_:Quest = null;
         var _loc3_:Quest = getQuest(param1);
         if(!_loc3_.clientBuffer)
         {
            _loc3_.setBuffer(null);
         }
         if(_loc3_.getCurrentOrNextStep().target != null)
         {
            QuestTargetManager.disposeTarget(_loc3_);
         }
         var _loc4_:int = 1;
         while(_loc4_ < param2 + 1)
         {
            _loc3_.updateStepStatus(_loc4_,true);
            _loc4_++;
         }
         if(param2 == _loc3_.getStepVec().length)
         {
            _loc3_.status = QuestStatus.COMPLETE;
            _loc3_.isLastComplete = true;
            openNextQuests();
            if(Boolean(_loc3_.autoNext) && getQuest(param1 + 1) != null)
            {
               (_loc5_ = getQuest(param1 + 1)).status = QuestStatus.IN_PROGRESS;
               _loc5_.setBuffer(null);
            }
            dispatchEvent(QuestEvent.COMPLETE,param1);
         }
         else
         {
            _loc3_.status = QuestStatus.IN_PROGRESS;
            dispatchEvent(QuestEvent.STEP_COMPLETE,param1,param2);
         }
      }
      
      private static function processUpdateOld(param1:int, param2:int) : void
      {
         QuestManager.dispatchEvent(QuestEvent.STEP_UPDATE_BUFFER,param1,param2);
      }
      
      private static function processUpdateNew(param1:int, param2:int) : void
      {
         QuestManager.dispatchEvent(QuestEvent.STEP_UPDATE_BUFFER,param1,param2);
      }
      
      private static function parseOutput(param1:IDataInput, param2:int = 0) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = int(param1.readUnsignedInt());
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_ = uint(param1.readUnsignedInt());
            _loc4_ = int(param1.readShort());
            _loc5_ = uint(param1.readUnsignedInt());
            if(_loc3_ == 1)
            {
               ActorManager.actorInfo.coins += _loc4_;
               if(param2 != 1)
               {
                  AlertManager.showCoinsGainedAlert(_loc4_);
               }
            }
            else if(_loc3_ != 14)
            {
               if(ItemConfig.getItemDefinition(_loc3_) == null || ItemConfig.getItemDefinition(_loc3_).isHide)
               {
                  return;
               }
               ItemManager.addItem(_loc3_,_loc4_,_loc5_);
               if(ItemCategoryUtil.isMedal(_loc3_))
               {
                  AlertManager.showMedalGainedAlert(_loc3_);
                  if(ItemConfig.getMedalDefinition(_loc3_).title != "")
                  {
                     ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getMedalDefinition(_loc3_).title + "称号]");
                  }
               }
               else if(_loc3_ == 601545)
               {
                  ServerMessager.addMessage("恭喜你获得了20个竹叶");
               }
               else if(ItemCategoryUtil.findItemCategoryByReferenceId(_loc3_) != ItemCategory.SPECIAL_ITEM)
               {
                  if(_loc3_ != 27 && param2 != 1)
                  {
                     AlertManager.showItemGainedAlert(_loc3_,_loc4_);
                  }
               }
            }
            _loc7_++;
         }
         _loc6_ = int(param1.readUnsignedInt());
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            _loc3_ = uint(param1.readUnsignedInt());
            _loc4_ = int(param1.readShort());
            _loc5_ = uint(param1.readUnsignedInt());
            ItemManager.reduceItemQuantity(_loc3_,Math.abs(_loc4_));
            _loc8_++;
         }
         var _loc9_:uint = uint(param1.readUnsignedInt());
         var _loc10_:uint = uint(param1.readUnsignedInt());
         if(_loc9_ != 0)
         {
            PetInfoManager.requestAddToBagFromStorage(_loc10_,_loc9_);
         }
      }
      
      private static function onUpdateQuestBufferErr(param1:MessageEvent) : void
      {
         ErrorMap.parseStatusCode(param1.message.statusCode);
         clearHandler1015();
      }
      
      private static function clearHandler1015() : void
      {
         Connection.removeCommandListener(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferSuc);
         Connection.removeErrorHandler(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,onUpdateQuestBufferErr);
      }
      
      public static function get dependenceMap() : DependenceMap
      {
         if(_dependenceMap == null)
         {
            _dependenceMap = new DependenceMap();
         }
         return _dependenceMap;
      }
      
      public static function isQuestNew(param1:int) : Boolean
      {
         return false;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:String, param2:int = -1, param3:int = -1) : void
      {
         if(_dispatcher.hasEventListener(param1))
         {
            _dispatcher.dispatchEvent(new QuestEvent(param1,param2,param3));
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
   }
}
