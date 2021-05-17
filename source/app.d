import std.stdio;
import core.time;
import std.conv;
import std.functional;
import core.thread.osthread;

struct Timer {
	long ticks;
	void start() {
		ticks = MonoTime.currTime().ticks();
	}
	long stop() {
		return MonoTime.currTime().ticks() - ticks;
	}
	void stop(string s) {
		writeln(s ~ ": " ~ to!string(MonoTime.currTime().ticks() - ticks));
	}
}

void threadtest() {
	t.stop("Thread creation");
}
__gshared Timer t;

void main()
{
	/*auto mt = MonoTime.currTime();
	long t = mt.ticks();
	writeln("Edit source/app.d to start your project.");
	writeln(mt.ticksPerSecond());
	for (int i = 0; i < 1; i++) {writeln("Edit source/app.d to start your project.");}
	writeln((MonoTime.currTime() - mt).total!"nsecs"());
	//writeln(mt.ticks());
	writeln(MonoTime.currTime().ticks() - t);*/
	
	t.start();
	writeln("Edit source/app.d to start your project.");
	t.stop("Test");
	t.start();
	// hier könnte man eine lokale funktion benutzen um t in die funktion zu bringen(siehe delegates)
	auto threadid = createLowLevelThread(cast(void delegate() nothrow)toDelegate(&threadtest));
	joinLowLevelThread(threadid);
}
