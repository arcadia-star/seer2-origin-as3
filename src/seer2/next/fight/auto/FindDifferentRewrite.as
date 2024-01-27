package seer2.next.fight.auto {
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.TimerEvent;
import flash.utils.IDataInput;
import flash.utils.Timer;

public class FindDifferentRewrite {

    private static var instance:FindDifferentRewrite = new FindDifferentRewrite();


    private var _successCallback:Function;

    private var _errorCallback:Function;

    private var timer:Timer;

    public function FindDifferentRewrite() {
        this.timer = new Timer(400, 0);
        super();
    }

    public static function getInstance():FindDifferentRewrite {
        return instance;
    }

    public function sendAnswer(fakeHash:String, successCallback:Function, errorCallback:Function):void {
        this._successCallback = successCallback;
        this._errorCallback = errorCallback;
        Connection.addErrorHandler(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerifyError);
        Connection.addCommandListener(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerify);
        if (AutoFightVerifyConfig.getInfo(fakeHash) != null) {
            var answer:uint = AutoFightVerifyConfig.getInfo(fakeHash).answer;
            Connection.send(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, answer);
        } else {
            ServerMessager.addMessage("我去,居然没有收录这个数据!");
            Connection.send(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, 3);
        }
    }

    private function onStartFightVerify(event:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerifyError);
        Connection.removeCommandListener(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerify);
        var data:IDataInput = event.message.getRawData();
        var status:uint = uint(data.readUnsignedInt());
        if (status == 0 && this._successCallback != null) {
            this._successCallback();
            this._successCallback = null;
        } else if (status == 1 && this._successCallback != null) {
            ServerMessager.addMessage("选错了");
            timer.addEventListener(TimerEvent.TIMER, onError);
            timer.start();
            Connection.addCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111, verifyAgain);
        }
    }

    private function onError(event:TimerEvent):void {
        this._successCallback();
    }

    private function verifyAgain(param1:MessageEvent):void {
        timer.stop();
        Connection.removeCommandListener(CommandSet.START_FIGHT_SERVER_VERIFY_1111, verifyAgain);
        FightVerifyManager.onStartFightVerify(param1, _successCallback, _errorCallback);
    }

    private function onStartFightVerifyError(event:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerifyError);
        Connection.removeCommandListener(CommandSet.START_FIGHT_CLIENT_VERIFY_1112, onStartFightVerify);
        if (this._errorCallback != null) {
            this._errorCallback();
            ServerMessager.addMessage("???出错了!");
            this._errorCallback = null;
        }
    }
}
}

