@set PS=powershell.exe -Sta -NonInteractive -NoProfile -NoLogo -ExecutionPolicy RemoteSigned
@%PS% ./%~n0.ps1 %*
