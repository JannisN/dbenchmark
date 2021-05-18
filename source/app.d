import std.stdio;
import core.time;
import std.conv;
import std.functional;
import core.thread.osthread;
import core.stdc.stdlib;
import core.memory;

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
	writeln("Ticks per second: " ~ to!string(MonoTime().ticksPerSecond));
	t.stop("Test");
	t.start();
	// hier könnte man eine lokale funktion benutzen um t in die funktion zu bringen(siehe delegates)
	auto threadid = createLowLevelThread(cast(void delegate() nothrow)toDelegate(&threadtest));
	joinLowLevelThread(threadid);
	t.start();
	auto ia = new int[100];
	t.stop("Test");
	t.start();
	auto ia3 = new int[100];
	ia3[12] = 123;
	t.stop("Test");
	t.start();
	auto ia2 = malloc(100);
	t.stop("Test");
	t.start();
	int[10] ia4 = void;
	ia4[0] = 12;
	for (int i = 0; i < 100; i++) {}
	t.stop("Test");
	for (int i = 0; i < 1000000; i++) {new int[1000];}
	t.start();
	GC.collect();
	t.stop("Collect");
}

//extern(C) __gshared bool rt_cmdline_enabled = false;
//extern(C) __gshared string[] rt_options = ["gcopt=gc:manual disable:1"];
extern(C) __gshared string[] rt_options = ["gcopt=profile:1"];
