package seer2.next.fight.auto
{
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.net.Command;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.core.map.grids.HashMap;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.ui.UIManager;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.utils.Timer;

public class AutoFightPanel extends Sprite
{

    private static var _instance:AutoFightPanel;

    public static var isRunning:Boolean = false;

    public static var FightOverEvent:EventDispatcher = new EventDispatcher();

    public static const FIGHT_OVER:String = "fightOverEvent";

    public static var isYanshu:Boolean = false;

    private static const HELP:String = "☆该版本为第四代测试版,可能存在一定bug,若出现bug可以在星火群或二号船群反馈;出招顺序可不填,默认使用第一个技能;次数可不填,默认无限循环;点击监视,可以查看剩余次数;\n出招顺序格式:\n如 2342(2,2)T3(3,-1)\n代表依次使用第二 三 四 二个技能,括号内第一个数字\"2\"代表从出招顺序的第二个技能开始循环,第二个数字代表循环次数,如果第二个数字为-1,则代表无限循环\n注意,括号和逗号请使用英文括号和逗号;不允许出现\"( , )( , )\",也就是说,两个循环不可以写在一块;每个循环只生效一次,比如在上面的例子中,(2,2)生效过一次后,就不再生效了\n所以上面的这个例子,相当于 2342342342T342T342T342T342T3...\n行动代号表: 1,2,3,4,5 技能 ; R 逃跑 ; T 补血(默认使用350高效药) ; S 捕捉 ; a,b,c,d,e 不同种类的怒气药 ; A,B,C,D,E,F 换场(换死亡的精灵会直接使用高级复活药,换现在正在战斗的精灵会直接使用一技能)";

    public static var logTxt:String = new String();


    private var isCure:Boolean = true;

    private var UI1:MovieClip;

    private var yanshuBtn:SimpleButton;

    private var background:Sprite;

    private var _crossSymbleMc:MovieClip;

    private var _crossSymbleMc2:MovieClip;

    private var commandId:TextField;

    private var paramId:TextField;

    private var sequence:TextField;

    private var txt1:TextField;

    private var txt2:TextField;

    private var txt3:TextField;

    private var txtOut:TextField;

    private var txtOut2:TextField;

    private var txtOut3:TextField;

    private var startBtn:SimpleButton;

    private var endBtn:SimpleButton;

    private var helpBtn:SimpleButton;

    private var monitorBtn:SimpleButton;

    private var cureBtn:SimpleButton;

    private var _curCommand:Command;

    private var _specialCmdMap:HashMap;

    private var delayTimer:Timer;

    private var checkStartTimer:Timer;

    private var index:int = 0;

    private var curNode:*;

    private var opArray:Array;

    private var operationMap:HashMap;

    private var fightTimeTxt:TextField;

    private var fightTime:int;

    public function AutoFightPanel()
    {
        super();
        if(_instance)
        {
            throw new Error("(自动刷怪)重复实例化");
        }
        this.UI1 = UIManager.getMovieClip("MapPanelProtocolUI");
        initset();
        initSpecialCommand();
        initMap();
    }

    public static function instance() : AutoFightPanel
    {
        if(_instance == null)
        {
            _instance = new AutoFightPanel();
        }
        return _instance;
    }

    public static function createInputText(_x:int, _y:int, _height:int, _width:int) : TextField
    {
        var textField:TextField = new TextField();
        var textFormat:TextFormat = new TextFormat();
        textField.text = "";
        textField.x = _x;
        textField.y = _y;
        textField.height = _height;
        textField.width = _width;
        textField.type = TextFieldType.INPUT;
        textField.background = true;
        textField.backgroundColor = 4279427;
        textField.alpha = 0.9;
        textFormat.size = _height - 3;
        textFormat.color = 16048569;
        textField.defaultTextFormat = textFormat;
        return textField;
    }

    public static function createStaticText(_x:int, _y:int, _height:int, _width:int, _mouseEnabled:Boolean) : TextField
    {
        var textField:TextField = new TextField();
        var textFormat:TextFormat = new TextFormat();
        textField.text = "";
        textField.x = _x;
        textField.y = _y;
        textField.height = _height;
        textField.width = _width;
        textField.mouseEnabled = _mouseEnabled;
        textField.alpha = 0.9;
        textFormat.size = _height - 3;
        textFormat.color = 10798591;
        textField.defaultTextFormat = textFormat;
        return textField;
    }

    private function initset() : void
    {
        delayTimer = new Timer(1000,0);
        checkStartTimer = new Timer(2500,0);
        this.background = new Sprite();
        this.background.x = 0;
        this.background.y = 0;
        addChild(this.background);
        this._crossSymbleMc = this.UI1["crossSymble0"];
        _crossSymbleMc.x = 100;
        _crossSymbleMc.y = 237;
        _crossSymbleMc.visible = false;
        this._crossSymbleMc2 = this.UI1["crossSymble1"];
        _crossSymbleMc2.x = 205;
        _crossSymbleMc2.y = 237;
        this.txt1 = createStaticText(17,40,24,75,false);
        this.txt1.text = "协议号:";
        this.txt2 = createStaticText(17,76,24,75,false);
        this.txt2.text = "参数:";
        this.txt3 = createStaticText(30,120,24,105,false);
        this.txt3.text = "出招顺序:";
        this.txtOut = createStaticText(17,260,24,198,true);
        this.txtOut2 = new TextField();
        var tF:TextFormat = new TextFormat();
        tF.size = 16;
        tF.color = 10798591;
        txtOut2.defaultTextFormat = tF;
        txtOut2.text = HELP;
        txtOut2.x = 251;
        txtOut2.y = 53;
        txtOut2.height = 240;
        txtOut2.width = 265;
        txtOut2.mouseEnabled = true;
        txtOut2.wordWrap = true;
        txtOut2.alpha = 0.9;
        this.txtOut3 = new TextField();
        txtOut3.defaultTextFormat = tF;
        txtOut3.text = logTxt;
        txtOut3.x = 251;
        txtOut3.y = 53;
        txtOut3.height = 240;
        txtOut3.width = 265;
        txtOut3.mouseEnabled = true;
        txtOut3.wordWrap = true;
        txtOut3.alpha = 0.9;
        txtOut3.visible = false;
        this.commandId = createInputText(98,40,24,116);
        this.paramId = createInputText(98,76,24,116);
        this.sequence = createInputText(17,154,25,198);
        this.fightTimeTxt = createInputText(160,189,25,55);
        fightTimeTxt.text = "次数";
        this.yanshuBtn = createButton(20,227,25,95,"鼹鼠功能","鼹鼠功能");
        this.cureBtn = createButton(125,227,25,95,"自动恢复","自动恢复");
        this.helpBtn = createButton(251,20,25,55,"帮助","帮助");
        this.monitorBtn = createButton(321,20,25,55,"监视","监视");
        yanshuBtn.addEventListener(MouseEvent.CLICK,this.onYanshu);
        cureBtn.addEventListener(MouseEvent.CLICK,this.onCure);
        helpBtn.addEventListener(MouseEvent.CLICK,this.onHelp);
        monitorBtn.addEventListener(MouseEvent.CLICK,this.onMonitor);
        this.startBtn = createButton(20,189,25,55,"开始","开始");
        this.endBtn = createButton(90,189,25,55,"结束","结束");
        startBtn.addEventListener(MouseEvent.CLICK,this.onStart);
        endBtn.addEventListener(MouseEvent.CLICK,this.onEnd);
        endBtn.enabled = false;
        endBtn.alpha = 0.7;
        this.background.addChild(this.commandId);
        this.background.addChild(this.paramId);
        this.background.addChild(this.sequence);
        this.background.addChild(this.fightTimeTxt);
        this.background.addChild(this.txt1);
        this.background.addChild(this.txt2);
        this.background.addChild(this.txt3);
        this.background.addChild(this.txtOut);
        this.background.addChild(this.txtOut2);
        this.background.addChild(this.txtOut3);
        this.background.addChild(this.startBtn);
        this.background.addChild(this.endBtn);
        this.background.addChild(this.yanshuBtn);
        this.background.addChild(this.cureBtn);
        this.background.addChild(this._crossSymbleMc);
        this.background.addChild(this._crossSymbleMc2);
        this.background.addChild(this.helpBtn);
        this.background.addChild(this.monitorBtn);
    }

    private function initSpecialCommand() : void
    {
        this._specialCmdMap = new HashMap();
        this._specialCmdMap.put(CommandSet.FIGHT_START_WILD_1500,{"handler":this.fightWithWildHandler});
        this._specialCmdMap.put(CommandSet.FIGHT_NPC_1511,{"handler":this.fightWithNPCHandler});
        this._specialCmdMap.put(CommandSet.BOSS_START_FIGHT_1046,{"handler":this.FightWithSPTHandler});
    }

    private function initMap() : void
    {
        this.operationMap = new HashMap();
        operationMap.put("1",0);
        operationMap.put("2",1);
        operationMap.put("3",2);
        operationMap.put("4",3);
        operationMap.put("5",4);
        operationMap.put("R",6);
        operationMap.put("T",7);
        operationMap.put("S",8);
        operationMap.put("a",21);
        operationMap.put("b",22);
        operationMap.put("c",23);
        operationMap.put("d",24);
        operationMap.put("e",25);
        operationMap.put("A",11);
        operationMap.put("B",12);
        operationMap.put("C",13);
        operationMap.put("D",14);
        operationMap.put("E",15);
        operationMap.put("F",16);
    }

    public function getOperation() : int
    {
        if(curNode == null)
        {
            curNode = getNode();
        }
        if(curNode.next == null)
        {
            var temp:* = this.curNode;
            curNode.next = getNode();
            curNode = curNode.next;
            return int(operationMap.getValue(temp.operation as String));
        }
        if(curNode.next != null && curNode.type as String == "normal")
        {
            temp = this.curNode;
            curNode = curNode.next;
            return int(operationMap.getValue(temp.operation as String));
        }
        if(curNode.time as int > 0 && curNode.type as String == "loop")
        {
            curNode.time = (curNode.time as int) - 1;
            temp = this.curNode;
            curNode = curNode.next;
            return int(operationMap.getValue(temp.operation as String));
        }
        if(curNode.time as int == 0)
        {
            temp = this.curNode;
            curNode.type = "normal";
            curNode.next = getNode();
            curNode = curNode.next;
            return int(operationMap.getValue(temp.operation as String));
        }
        temp = this.curNode;
        curNode = curNode.next;
        return int(operationMap.getValue(temp.operation as String));
    }

    private function getNode() : *
    {
        var currentChar:String = null;
        var text_:String = this.sequence.text;
        var curN:String = "";
        var curT:String = "";
        if(text_.length == 0)
        {
            return {
                "next":null,
                "operation":1,
                "time":0,
                "type":"abnormal"
            };
        }
        if((currentChar = text_.charAt(index)) != "")
        {
            if(text_.charAt(index + 1) == "(")
            {
                index++;
                while(text_.charAt(++index) != ",")
                {
                    if(text_.charAt(index) == "")
                    {
                        this.txtOut.text = "格式错误!";
                        return {
                            "next":this.opArray[0],
                            "operation":currentChar,
                            "time":-1,
                            "type":"abnormal"
                        };
                    }
                    curN += text_.charAt(index);
                }
                while(text_.charAt(++index) != ")")
                {
                    if(text_.charAt(index) == "")
                    {
                        this.txtOut.text = "格式错误!";
                        return {
                            "next":this.opArray[0],
                            "operation":currentChar,
                            "time":-1,
                            "type":"abnormal"
                        };
                    }
                    curT += text_.charAt(index);
                }
                curN = int(curN) - 1 + "";
                index++;
                var temp:* = {
                    "next":null,
                    "operation":currentChar,
                    "time":int(curT),
                    "type":"loop"
                };
                opArray.push(temp);
                if(this.opArray[int(curN)] == undefined)
                {
                    this.txtOut.text = "数组越界!";
                    opArray.pop();
                    return {
                        "next":this.opArray[0],
                        "operation":currentChar,
                        "time":1,
                        "type":"abnormal"
                    };
                }
                temp.next = this.opArray[int(curN)];
                return temp;
            }
            index++;
            temp = {
                "next":null,
                "operation":currentChar,
                "time":0,
                "type":"normal"
            };
            opArray.push(temp);
            return temp;
        }
        this.index = 0;
        this.opArray = new Array();
        return getNode();
    }

    private function onYanshu(event:MouseEvent) : void
    {
        isYanshu = !isYanshu;
        _crossSymbleMc.visible = isYanshu;
    }

    private function onHelp(event:MouseEvent) : void
    {
        txtOut3.visible = false;
        txtOut2.visible = true;
    }

    private function onMonitor(event:MouseEvent) : void
    {
        txtOut3.text = logTxt;
        txtOut3.visible = true;
        txtOut2.visible = false;
    }

    private function onCure(event:MouseEvent) : void
    {
        isCure = !isCure;
        _crossSymbleMc2.visible = isCure;
    }

    private function onEnd(event:MouseEvent) : void
    {
        this.delayTimer.reset();
        this.curNode = null;
        this.index = 0;
        this.opArray = null;
        isRunning = false;
        startBtn.enabled = true;
        startBtn.alpha = 1;
        endBtn.enabled = false;
        endBtn.alpha = 0.7;
    }

    private function onStart(event:MouseEvent) : void
    {
        var h:Object = null;
        var reStart:Function = function(event:TimerEvent):void
        {
            if(!isRunning)
            {
                checkStartTimer.removeEventListener(TimerEvent.TIMER,reStart);
                this.checkStartTimer.reset();
            }
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "发送一次战斗请求,等待4号回包\n";
            h.handler(uint(paramId.text));
        };
        var FightStarted:Function = function(param1:MessageEvent):void
        {
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "收到服务器4号回包,已经开始战斗\n";
            checkStartTimer.removeEventListener(TimerEvent.TIMER,reStart);
            Connection.removeCommandListener(CommandSet.FIGHT_LOAD_MAP_4,FightStarted);
            checkStartTimer.reset();
        };
        if(uint(this.commandId.text) == 0 || uint(this.paramId.text) == 0)
        {
            this.txtOut.text = "输入有误!";
            return;
        }
        this._curCommand = Command.getCommand(uint(this.commandId.text));
        h = this._specialCmdMap.getValue(this._curCommand);
        if(h != null)
        {
            if(isRunning)
            {
                this.fightTime--;
            }
            else
            {
                if(fightTimeTxt.text == "0")
                {
                    return;
                }
                this.fightTime = uint(fightTimeTxt.text) - 1;
            }
            Connection.addCommandListener(CommandSet.FIGHT_LOAD_MAP_4,FightStarted);
            checkStartTimer.addEventListener(TimerEvent.TIMER,reStart);
            checkStartTimer.start();
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "准备开始战斗,发送一次战斗请求,等待4号回包\n";
            h.handler(uint(this.paramId.text));
            startBtn.enabled = false;
            startBtn.alpha = 0.7;
            endBtn.enabled = true;
            endBtn.alpha = 1;
            isRunning = true;
            this.opArray = new Array();
            FightManager.addEventListener(FightStartEvent.START_ERROR,this.FightError);
            FightOverEvent.addEventListener(FIGHT_OVER,this.continueFight);
            return;
        }
        this.txtOut.text = "只支持1500,1046,1511协议";
    }

    private function continueFight(event:Event) : void
    {
        var reStart:Function = function(param1:MessageEvent):void
        {
            delayTimer.removeEventListener(TimerEvent.TIMER,cure);
            delayTimer.reset();
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "收到1215协议回包\n";
            Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215,reStart);
            var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
            for each(var _loc3_:PetInfo in _loc2_)
            {
                _loc3_.hp = _loc3_.maxHp;
                PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE,_loc3_);
            }
            curNode = null;
            index = 0;
            opArray = null;
            startBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        };
        var cure:Function = function(event:TimerEvent):void
        {
            if(!isRunning)
            {
                checkStartTimer.removeEventListener(TimerEvent.TIMER,reStart);
            }
            if(isCure)
            {
                txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "发送一次恢复体力请求,等待服务器1215回包...\n";
                Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215,reStart);
                Connection.send(CommandSet.TREAT_ALL_PET_1215);
            }
            else
            {
                delayTimer.removeEventListener(TimerEvent.TIMER,cure);
                delayTimer.reset();
                curNode = null;
                index = 0;
                opArray = null;
                startBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
        };
        FightOverEvent.removeEventListener(FIGHT_OVER,this.continueFight);
        if(this.fightTime == 0)
        {
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "结束对战\n";
            endBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }
        if(isRunning)
        {
            txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "继续对战,还有" + this.fightTime + "次战斗\n";
            this.delayTimer.addEventListener(TimerEvent.TIMER,cure);
            delayTimer.start();
        }
    }

    private function FightError(event:FightStartEvent) : void
    {
        txtOut3.text += "[" + new Date().toLocaleTimeString() + "]" + "战斗出现未知错误!\n";
        checkStartTimer.stop();
        FightManager.removeEventListener(FightStartEvent.START_ERROR,this.FightError);
        this.endBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    private function fightWithWildHandler(param1:uint) : void
    {
        FightManager.startFightWithWild(uint(param1));
    }

    private function fightWithNPCHandler(param1:uint) : void
    {
        FightManager.startFightWithNPC(uint(param1));
    }

    private function FightWithSPTHandler(param1:uint) : void
    {
        FightManager.startFightWithSPTBoss(uint(param1));
    }

    private function createButton(_x:int, _y:int, _height:int, _width:int, normal:String, down:String) : SimpleButton
    {
        var myButton:SimpleButton;
        var createButtonState:Function = function(color:uint, label:String):Sprite
        {
            var state:Sprite = new Sprite();
            state.graphics.beginFill(color);
            state.graphics.drawRect(0,0,_width,_height);
            state.graphics.endFill();
            var labelField:TextField = createStaticText(0,0,_height,_width,false);
            labelField.text = label;
            labelField.selectable = false;
            state.addChild(labelField);
            return state;
        };
        var normalState:Sprite = createButtonState(5591163,normal);
        var hoverState:Sprite = createButtonState(7700386,normal);
        var downState:Sprite = createButtonState(6369338,down);
        var disabledState:Sprite = createButtonState(6369338,"已禁用");
        disabledState.alpha = 0.7;
        myButton = new SimpleButton(normalState,hoverState,downState,disabledState);
        myButton.x = _x;
        myButton.y = _y;
        return myButton;
    }

    private function initEvent() : void
    {
    }
}
}

