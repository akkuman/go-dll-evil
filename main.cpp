#include <stdio.h>
#include <windows.h>

typedef int(*lpAdd)(int, int);

int main(int argc, char *argv[])
{
	HINSTANCE DllAddr;
	lpAdd addFun;

	DllAddr = LoadLibraryW(L"add.dll");

	addFun = (lpAdd)GetProcAddress(DllAddr, "add");
	if (NULL != addFun)
	{
		int res = addFun(100, 200);
		printf("result: %d \n", res);
	}

	system("pause");
	return 0;
}