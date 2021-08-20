#include <windows.h>

extern "C" int __declspec(dllexport)add(int x, int y)
{
	return x + y;
}

BOOL APIENTRY DllMain(HANDLE handle, DWORD dword, LPVOID lpvoid)
{

	return true;
}