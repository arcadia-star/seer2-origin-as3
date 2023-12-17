package com.taomee.seer2.app.questTiny.items
{
   import com.taomee.seer2.app.component.tree.TreeItem;
   import com.taomee.seer2.app.config.MapConfig;
   import com.taomee.seer2.app.questTiny.QuestTinyStepItem;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.constant.QuestType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class QuestTinyItem extends TreeItem
   {
      
      private static var _instanceVec:Vector.<QuestTinyItem> = new Vector.<QuestTinyItem>();
       
      
      private var _mainUI:MovieClip;
      
      private var _nameTxt:TextField;
      
      private var _flagMc:MovieClip;
      
      private var _selectedMc:MovieClip;
      
      private var _quest:Quest;
      
      private var _starQuest:Object;
      
      private const specialList:Array = [30040,10133,10134,10136,10161,10164,10170,10175,10176,10177,10178,10180,10181,10186,10188,10190,10193,10195,10197,10198,10199,10201,10228,10229,10230];
      
      public function QuestTinyItem()
      {
         this._mainUI = UIManager.getMovieClip("QuestTinyItemUI");
         this._nameTxt = this._mainUI["txt"];
         this._flagMc = this._mainUI["flagMc"];
         this._flagMc.gotoAndStop(1);
         this._selectedMc = this._mainUI["selectedMc"];
         this.isSelected = false;
         super(this._mainUI);
         addInstance(this);
         this._mainUI.mouseChildren = false;
         this._mainUI.buttonMode = true;
         this._mainUI.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private static function addInstance(param1:QuestTinyItem) : void
      {
         _instanceVec.push(param1);
      }
      
      private static function updateSelection(param1:QuestTinyItem) : void
      {
         var _loc2_:QuestTinyItem = null;
         for each(_loc2_ in _instanceVec)
         {
            if(_loc2_ == param1)
            {
               _loc2_.isSelected = true;
            }
            else
            {
               _loc2_.isSelected = false;
            }
         }
      }
      
      public static function clearSelection() : void
      {
         var _loc1_:QuestTinyItem = null;
         for each(_loc1_ in _instanceVec)
         {
            _loc1_.isSelected = false;
         }
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         updateSelection(this);
         showChildren = !showChildren;
      }
      
      override public function update(param1:*) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = null;
         this._quest = param1 as Quest;
         if((param1 as Object).id == -1)
         {
            _loc2_ = "【日常】";
            this._starQuest = param1;
            this._nameTxt.text = _loc2_ + this._starQuest.title;
            this._flagMc.visible = false;
            changeToLen(1,QuestTinyStepItem);
            showChildren = false;
            _loc3_ = "<a href=\'event:" + this._starQuest.module + "\'><font color=\'#33EE00\'><u>" + this._starQuest.des + "</u></font></a>";
            getChildItemAt(0).update({
               "data":this.data,
               "txt":_loc3_,
               "para":this._starQuest.para,
               "go":false
            });
         }
         else
         {
            this.updateName();
            this.updateFlag();
            this.updateStep();
         }
      }
      
      override public function get data() : *
      {
         return this._quest;
      }
      
      override public function dispose() : void
      {
         this._mainUI.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.dispose();
      }
      
      private function updateName() : void
      {
         var _loc1_:String = "";
         if(this._quest.id == 83 || this._quest.id == 86)
         {
            _loc1_ = "【新手】";
         }
         else if(this._quest.type == QuestType.CHAPTER || this._quest.type == QuestType.STORY)
         {
            _loc1_ = "【主线】";
         }
         else if(this._quest.type == QuestType.NPC || this._quest.type == QuestType.PET || this.specialList.indexOf(this._quest.id) != -1)
         {
            _loc1_ = "【支线】";
         }
         else if(this._quest.type == QuestType.ACTIVITY)
         {
            _loc1_ = "【活动】";
         }
         this._nameTxt.text = _loc1_ + this._quest.name;
      }
      
      private function updateFlag() : void
      {
         if(Boolean(this._quest.isNewOnline) && this._quest.status == QuestStatus.ACCEPTABLE)
         {
            this._flagMc.gotoAndStop(1);
         }
         else if(!this._quest.isNewOnline && this._quest.status == QuestStatus.ACCEPTABLE)
         {
            this._flagMc.gotoAndStop(2);
         }
         else if(this._quest.status == QuestStatus.IN_PROGRESS)
         {
            this._flagMc.gotoAndStop(3);
         }
         else if(this._quest.status == QuestStatus.COMPLETE)
         {
            this._flagMc.gotoAndStop(4);
         }
      }
      
      private function updateStep() : void
      {
         var _loc1_:String = null;
         var _loc2_:RegExp = null;
         var _loc3_:Array = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:* = null;
         if(this._quest.status == QuestStatus.IN_PROGRESS)
         {
            if(this._quest.type == QuestType.PET)
            {
               _loc1_ = String(this._quest.des);
            }
            else
            {
               _loc1_ = String(this._quest.getCurrentOrNextStep().des);
            }
            _loc2_ = /(?<!')#.+?#/g;
            _loc3_ = new Array();
            if(_loc1_ != null && _loc1_.match(_loc2_) != null)
            {
               _loc3_ = _loc1_.match(_loc2_);
               if(_loc3_.length == 0 && this.specialList.indexOf(this._quest.id) != -1)
               {
                  changeToLen(1,QuestTinyStepItem);
                  _loc4_ = "<a href=\'event:" + "BagginsLogPanel" + "\'><font color=\'#33EE00\'><u>" + this._quest.getCurrentOrNextStep().des + "</u></font></a>";
                  getChildItemAt(0).update({
                     "data":this.data,
                     "txt":_loc4_
                  });
               }
               else
               {
                  changeToLen(_loc3_.length,QuestTinyStepItem);
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_.length)
                  {
                     _loc6_ = (_loc3_[_loc5_] as String).split("#").join("");
                     _loc7_ = "<a href=\'event:" + MapConfig.formMapNameGetMapId(_loc6_) + "\'><font color=\'#33EE00\'><u>" + "前往" + _loc6_.replace("(副本)","").replace("[副本]","") + "</u></font></a>";
                     getChildItemAt(_loc5_).update({
                        "data":this.data,
                        "txt":_loc7_
                     });
                     _loc5_++;
                  }
                  showChildren = true;
               }
            }
            else
            {
               changeToLen(0,QuestTinyStepItem);
               showChildren = false;
            }
         }
         else if(this._quest.status == QuestStatus.ACCEPTABLE)
         {
            changeToLen(1,QuestTinyStepItem);
            getChildItemAt(0).update({
               "data":this.data,
               "txt":"接取任务",
               "go":true
            });
         }
         else
         {
            changeToLen(0,QuestTinyStepItem);
            showChildren = false;
         }
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         this._selectedMc.visible = param1;
      }
   }
}
