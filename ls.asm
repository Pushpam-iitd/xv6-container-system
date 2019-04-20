
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:



int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 24                	jle    41 <main+0x41>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 6b 04 00 00       	call   4a0 <ls>
  for(i=1; i<argc; i++)
  35:	83 c4 10             	add    $0x10,%esp
  38:	39 f3                	cmp    %esi,%ebx
  3a:	75 ec                	jne    28 <main+0x28>
  exit();
  3c:	e8 11 07 00 00       	call   752 <exit>
    ls(".");
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 ba 0c 00 00       	push   $0xcba
  49:	e8 52 04 00 00       	call   4a0 <ls>
    exit();
  4e:	e8 ff 06 00 00       	call   752 <exit>
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <mystrcmp>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
  68:	31 db                	xor    %ebx,%ebx
{
  6a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
  6d:	80 39 00             	cmpb   $0x0,(%ecx)
  70:	0f b6 02             	movzbl (%edx),%eax
  73:	74 33                	je     a8 <mystrcmp+0x48>
  75:	8d 76 00             	lea    0x0(%esi),%esi
  78:	83 c1 01             	add    $0x1,%ecx
  7b:	83 c3 01             	add    $0x1,%ebx
  7e:	80 39 00             	cmpb   $0x0,(%ecx)
  81:	75 f5                	jne    78 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
  83:	84 c0                	test   %al,%al
  85:	74 51                	je     d8 <mystrcmp+0x78>
    int a =0,b=0;
  87:	31 f6                	xor    %esi,%esi
  89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
  90:	83 c2 01             	add    $0x1,%edx
  93:	83 c6 01             	add    $0x1,%esi
  96:	80 3a 00             	cmpb   $0x0,(%edx)
  99:	75 f5                	jne    90 <mystrcmp+0x30>
    if(a!=b)return 0;
  9b:	31 c0                	xor    %eax,%eax
  9d:	39 de                	cmp    %ebx,%esi
  9f:	74 0f                	je     b0 <mystrcmp+0x50>
}
  a1:	5b                   	pop    %ebx
  a2:	5e                   	pop    %esi
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    
  a5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
  a8:	84 c0                	test   %al,%al
  aa:	75 db                	jne    87 <mystrcmp+0x27>
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b0:	01 d3                	add    %edx,%ebx
  b2:	eb 13                	jmp    c7 <mystrcmp+0x67>
  b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
  b8:	83 c2 01             	add    $0x1,%edx
  bb:	83 c1 01             	add    $0x1,%ecx
  be:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
  c2:	38 41 ff             	cmp    %al,-0x1(%ecx)
  c5:	75 11                	jne    d8 <mystrcmp+0x78>
    while(a--){
  c7:	39 d3                	cmp    %edx,%ebx
  c9:	75 ed                	jne    b8 <mystrcmp+0x58>
}
  cb:	5b                   	pop    %ebx
    return 1;
  cc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  d1:	5e                   	pop    %esi
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d8:	5b                   	pop    %ebx
    if(a!=b)return 0;
  d9:	31 c0                	xor    %eax,%eax
}
  db:	5e                   	pop    %esi
  dc:	5d                   	pop    %ebp
  dd:	c3                   	ret    
  de:	66 90                	xchg   %ax,%ax

000000e0 <fmtname>:
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	56                   	push   %esi
  e4:	53                   	push   %ebx
  e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  e8:	83 ec 0c             	sub    $0xc,%esp
  eb:	53                   	push   %ebx
  ec:	e8 8f 04 00 00       	call   580 <strlen>
  f1:	83 c4 10             	add    $0x10,%esp
  f4:	01 d8                	add    %ebx,%eax
  f6:	73 0f                	jae    107 <fmtname+0x27>
  f8:	eb 12                	jmp    10c <fmtname+0x2c>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 100:	83 e8 01             	sub    $0x1,%eax
 103:	39 c3                	cmp    %eax,%ebx
 105:	77 05                	ja     10c <fmtname+0x2c>
 107:	80 38 2f             	cmpb   $0x2f,(%eax)
 10a:	75 f4                	jne    100 <fmtname+0x20>
  p++;
 10c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
 10f:	83 ec 0c             	sub    $0xc,%esp
 112:	53                   	push   %ebx
 113:	e8 68 04 00 00       	call   580 <strlen>
 118:	83 c4 10             	add    $0x10,%esp
 11b:	83 f8 0d             	cmp    $0xd,%eax
 11e:	77 4a                	ja     16a <fmtname+0x8a>
  memmove(buf, p, strlen(p));
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	53                   	push   %ebx
 124:	e8 57 04 00 00       	call   580 <strlen>
 129:	83 c4 0c             	add    $0xc,%esp
 12c:	50                   	push   %eax
 12d:	53                   	push   %ebx
 12e:	68 60 10 00 00       	push   $0x1060
 133:	e8 e8 05 00 00       	call   720 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 138:	89 1c 24             	mov    %ebx,(%esp)
 13b:	e8 40 04 00 00       	call   580 <strlen>
 140:	89 1c 24             	mov    %ebx,(%esp)
 143:	89 c6                	mov    %eax,%esi
  return buf;
 145:	bb 60 10 00 00       	mov    $0x1060,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 14a:	e8 31 04 00 00       	call   580 <strlen>
 14f:	ba 0e 00 00 00       	mov    $0xe,%edx
 154:	83 c4 0c             	add    $0xc,%esp
 157:	05 60 10 00 00       	add    $0x1060,%eax
 15c:	29 f2                	sub    %esi,%edx
 15e:	52                   	push   %edx
 15f:	6a 20                	push   $0x20
 161:	50                   	push   %eax
 162:	e8 49 04 00 00       	call   5b0 <memset>
  return buf;
 167:	83 c4 10             	add    $0x10,%esp
}
 16a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 16d:	89 d8                	mov    %ebx,%eax
 16f:	5b                   	pop    %ebx
 170:	5e                   	pop    %esi
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <ls.part.0>:
ls(char *path)
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
 186:	89 c3                	mov    %eax,%ebx
 188:	81 ec 64 02 00 00    	sub    $0x264,%esp
  if((fd = open(path, 0)) < 0){
 18e:	6a 00                	push   $0x0
 190:	50                   	push   %eax
 191:	e8 fc 05 00 00       	call   792 <open>
 196:	83 c4 10             	add    $0x10,%esp
 199:	85 c0                	test   %eax,%eax
 19b:	0f 88 af 00 00 00    	js     250 <ls.part.0+0xd0>
 1a1:	89 c6                	mov    %eax,%esi
  if(fstat(fd, &st) < 0){
 1a3:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 1a9:	83 ec 08             	sub    $0x8,%esp
 1ac:	50                   	push   %eax
 1ad:	56                   	push   %esi
 1ae:	e8 f7 05 00 00       	call   7aa <fstat>
 1b3:	83 c4 10             	add    $0x10,%esp
 1b6:	85 c0                	test   %eax,%eax
 1b8:	0f 88 e2 00 00 00    	js     2a0 <ls.part.0+0x120>
  switch(st.type){
 1be:	0f bf bd d0 fd ff ff 	movswl -0x230(%ebp),%edi
 1c5:	66 83 ff 01          	cmp    $0x1,%di
 1c9:	0f 84 a1 00 00 00    	je     270 <ls.part.0+0xf0>
 1cf:	66 83 ff 02          	cmp    $0x2,%di
 1d3:	75 63                	jne    238 <ls.part.0+0xb8>
    for (int i = 0; i < num_all_files; i++) {
 1d5:	a1 c4 7d 03 00       	mov    0x37dc4,%eax
 1da:	85 c0                	test   %eax,%eax
 1dc:	0f 8e f3 00 00 00    	jle    2d5 <ls.part.0+0x155>
 1e2:	31 ff                	xor    %edi,%edi
 1e4:	89 b5 b4 fd ff ff    	mov    %esi,-0x24c(%ebp)
 1ea:	eb 13                	jmp    1ff <ls.part.0+0x7f>
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c7 01             	add    $0x1,%edi
 1f3:	3b 3d c4 7d 03 00    	cmp    0x37dc4,%edi
 1f9:	0f 8d c9 00 00 00    	jge    2c8 <ls.part.0+0x148>
      if (mystrcmp(fmtname(path),all_files[i])==1){
 1ff:	83 ec 0c             	sub    $0xc,%esp
 202:	8b 34 bd 00 7f 03 00 	mov    0x37f00(,%edi,4),%esi
 209:	53                   	push   %ebx
 20a:	e8 d1 fe ff ff       	call   e0 <fmtname>
 20f:	5a                   	pop    %edx
 210:	59                   	pop    %ecx
 211:	56                   	push   %esi
 212:	50                   	push   %eax
 213:	e8 48 fe ff ff       	call   60 <mystrcmp>
 218:	83 c4 10             	add    $0x10,%esp
 21b:	83 f8 01             	cmp    $0x1,%eax
 21e:	75 d0                	jne    1f0 <ls.part.0+0x70>
        printf(1,"Yaha ghusa 2\n");
 220:	83 ec 08             	sub    $0x8,%esp
 223:	8b b5 b4 fd ff ff    	mov    -0x24c(%ebp),%esi
 229:	68 70 0c 00 00       	push   $0xc70
 22e:	6a 01                	push   $0x1
 230:	e8 bb 06 00 00       	call   8f0 <printf>
 235:	83 c4 10             	add    $0x10,%esp
  close(fd);
 238:	83 ec 0c             	sub    $0xc,%esp
 23b:	56                   	push   %esi
 23c:	e8 39 05 00 00       	call   77a <close>
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f4             	lea    -0xc(%ebp),%esp
 247:	5b                   	pop    %ebx
 248:	5e                   	pop    %esi
 249:	5f                   	pop    %edi
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret    
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	53                   	push   %ebx
 254:	68 48 0c 00 00       	push   $0xc48
 259:	6a 02                	push   $0x2
 25b:	e8 90 06 00 00       	call   8f0 <printf>
 260:	83 c4 10             	add    $0x10,%esp
}
 263:	8d 65 f4             	lea    -0xc(%ebp),%esp
 266:	5b                   	pop    %ebx
 267:	5e                   	pop    %esi
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	90                   	nop
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 270:	83 ec 0c             	sub    $0xc,%esp
 273:	53                   	push   %ebx
 274:	e8 07 03 00 00       	call   580 <strlen>
 279:	83 c0 10             	add    $0x10,%eax
 27c:	83 c4 10             	add    $0x10,%esp
 27f:	3d 00 02 00 00       	cmp    $0x200,%eax
 284:	0f 86 96 00 00 00    	jbe    320 <ls.part.0+0x1a0>
      printf(1, "ls: path too long\n");
 28a:	83 ec 08             	sub    $0x8,%esp
 28d:	68 8b 0c 00 00       	push   $0xc8b
 292:	6a 01                	push   $0x1
 294:	e8 57 06 00 00       	call   8f0 <printf>
 299:	83 c4 10             	add    $0x10,%esp
 29c:	eb 9a                	jmp    238 <ls.part.0+0xb8>
 29e:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot stat %s\n", path);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	53                   	push   %ebx
 2a4:	68 5c 0c 00 00       	push   $0xc5c
 2a9:	6a 02                	push   $0x2
 2ab:	e8 40 06 00 00       	call   8f0 <printf>
    close(fd);
 2b0:	89 34 24             	mov    %esi,(%esp)
 2b3:	e8 c2 04 00 00       	call   77a <close>
 2b8:	83 c4 10             	add    $0x10,%esp
}
 2bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2be:	5b                   	pop    %ebx
 2bf:	5e                   	pop    %esi
 2c0:	5f                   	pop    %edi
 2c1:	5d                   	pop    %ebp
 2c2:	c3                   	ret    
 2c3:	90                   	nop
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c8:	0f bf bd d0 fd ff ff 	movswl -0x230(%ebp),%edi
 2cf:	8b b5 b4 fd ff ff    	mov    -0x24c(%ebp),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 2d5:	83 ec 0c             	sub    $0xc,%esp
 2d8:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 2de:	8b 95 d8 fd ff ff    	mov    -0x228(%ebp),%edx
 2e4:	53                   	push   %ebx
 2e5:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 2eb:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 2f1:	e8 ea fd ff ff       	call   e0 <fmtname>
 2f6:	5a                   	pop    %edx
 2f7:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 2fd:	59                   	pop    %ecx
 2fe:	8b 8d b0 fd ff ff    	mov    -0x250(%ebp),%ecx
 304:	51                   	push   %ecx
 305:	52                   	push   %edx
 306:	57                   	push   %edi
 307:	50                   	push   %eax
 308:	68 7e 0c 00 00       	push   $0xc7e
 30d:	6a 01                	push   $0x1
 30f:	e8 dc 05 00 00       	call   8f0 <printf>
 314:	83 c4 20             	add    $0x20,%esp
 317:	e9 1c ff ff ff       	jmp    238 <ls.part.0+0xb8>
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(buf, path);
 320:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 326:	83 ec 08             	sub    $0x8,%esp
 329:	53                   	push   %ebx
 32a:	50                   	push   %eax
 32b:	e8 d0 01 00 00       	call   500 <strcpy>
    p = buf+strlen(buf);
 330:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 336:	89 04 24             	mov    %eax,(%esp)
 339:	e8 42 02 00 00       	call   580 <strlen>
 33e:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
    *p++ = '/';
 344:	83 c4 10             	add    $0x10,%esp
 347:	89 b5 b4 fd ff ff    	mov    %esi,-0x24c(%ebp)
    p = buf+strlen(buf);
 34d:	01 d0                	add    %edx,%eax
    *p++ = '/';
 34f:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 352:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
    *p++ = '/';
 358:	c6 00 2f             	movb   $0x2f,(%eax)
 35b:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 361:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 367:	83 ec 04             	sub    $0x4,%esp
 36a:	6a 10                	push   $0x10
 36c:	50                   	push   %eax
 36d:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 373:	e8 f2 03 00 00       	call   76a <read>
 378:	83 c4 10             	add    $0x10,%esp
 37b:	83 f8 10             	cmp    $0x10,%eax
 37e:	0f 85 0c 01 00 00    	jne    490 <ls.part.0+0x310>
      if(de.inum == 0)
 384:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 38b:	00 
 38c:	74 d3                	je     361 <ls.part.0+0x1e1>
      memmove(p, de.name, DIRSIZ);
 38e:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 394:	83 ec 04             	sub    $0x4,%esp
 397:	6a 0e                	push   $0xe
 399:	50                   	push   %eax
 39a:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 3a0:	e8 7b 03 00 00       	call   720 <memmove>
      p[DIRSIZ] = 0;
 3a5:	8b 85 b0 fd ff ff    	mov    -0x250(%ebp),%eax
 3ab:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 3af:	5f                   	pop    %edi
 3b0:	58                   	pop    %eax
 3b1:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 3b7:	50                   	push   %eax
 3b8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 3be:	50                   	push   %eax
 3bf:	e8 cc 02 00 00       	call   690 <stat>
 3c4:	83 c4 10             	add    $0x10,%esp
 3c7:	85 c0                	test   %eax,%eax
 3c9:	0f 88 a1 00 00 00    	js     470 <ls.part.0+0x2f0>
      for (int i = 0; i < num_all_files; i++) {
 3cf:	8b 35 c4 7d 03 00    	mov    0x37dc4,%esi
 3d5:	31 ff                	xor    %edi,%edi
 3d7:	85 f6                	test   %esi,%esi
 3d9:	7f 10                	jg     3eb <ls.part.0+0x26b>
 3db:	eb 3b                	jmp    418 <ls.part.0+0x298>
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	83 c7 01             	add    $0x1,%edi
 3e3:	3b 3d c4 7d 03 00    	cmp    0x37dc4,%edi
 3e9:	7d 2d                	jge    418 <ls.part.0+0x298>
        if (mystrcmp(fmtname(path),all_files[i])==1) {
 3eb:	83 ec 0c             	sub    $0xc,%esp
 3ee:	8b 34 bd 00 7f 03 00 	mov    0x37f00(,%edi,4),%esi
 3f5:	53                   	push   %ebx
 3f6:	e8 e5 fc ff ff       	call   e0 <fmtname>
 3fb:	5a                   	pop    %edx
 3fc:	59                   	pop    %ecx
 3fd:	56                   	push   %esi
 3fe:	50                   	push   %eax
 3ff:	e8 5c fc ff ff       	call   60 <mystrcmp>
 404:	83 c4 10             	add    $0x10,%esp
 407:	83 f8 01             	cmp    $0x1,%eax
 40a:	75 d4                	jne    3e0 <ls.part.0+0x260>
 40c:	e9 0f fe ff ff       	jmp    220 <ls.part.0+0xa0>
 411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 418:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 41e:	83 ec 0c             	sub    $0xc,%esp
 421:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 427:	8b 95 d8 fd ff ff    	mov    -0x228(%ebp),%edx
 42d:	0f bf bd d0 fd ff ff 	movswl -0x230(%ebp),%edi
 434:	50                   	push   %eax
 435:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 43b:	89 95 a8 fd ff ff    	mov    %edx,-0x258(%ebp)
 441:	e8 9a fc ff ff       	call   e0 <fmtname>
 446:	5a                   	pop    %edx
 447:	8b 95 a8 fd ff ff    	mov    -0x258(%ebp),%edx
 44d:	59                   	pop    %ecx
 44e:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 454:	51                   	push   %ecx
 455:	52                   	push   %edx
 456:	57                   	push   %edi
 457:	50                   	push   %eax
 458:	68 7e 0c 00 00       	push   $0xc7e
 45d:	6a 01                	push   $0x1
 45f:	e8 8c 04 00 00       	call   8f0 <printf>
 464:	83 c4 20             	add    $0x20,%esp
 467:	e9 f5 fe ff ff       	jmp    361 <ls.part.0+0x1e1>
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 470:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 476:	83 ec 04             	sub    $0x4,%esp
 479:	50                   	push   %eax
 47a:	68 5c 0c 00 00       	push   $0xc5c
 47f:	6a 01                	push   $0x1
 481:	e8 6a 04 00 00       	call   8f0 <printf>
 486:	83 c4 10             	add    $0x10,%esp
 489:	e9 d3 fe ff ff       	jmp    361 <ls.part.0+0x1e1>
 48e:	66 90                	xchg   %ax,%ax
 490:	8b b5 b4 fd ff ff    	mov    -0x24c(%ebp),%esi
 496:	e9 9d fd ff ff       	jmp    238 <ls.part.0+0xb8>
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <ls>:
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
 4a5:	8b 75 08             	mov    0x8(%ebp),%esi
  int cid = getcid();
 4a8:	e8 8d 03 00 00       	call   83a <getcid>
  printf(2, "cid is: %d\n", cid);
 4ad:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 4b0:	89 c3                	mov    %eax,%ebx
  printf(2, "cid is: %d\n", cid);
 4b2:	50                   	push   %eax
 4b3:	68 9e 0c 00 00       	push   $0xc9e
 4b8:	6a 02                	push   $0x2
 4ba:	e8 31 04 00 00       	call   8f0 <printf>
  printf(2,"File number %d\n",num_all_files);
 4bf:	83 c4 0c             	add    $0xc,%esp
 4c2:	ff 35 c4 7d 03 00    	pushl  0x37dc4
 4c8:	68 aa 0c 00 00       	push   $0xcaa
 4cd:	6a 02                	push   $0x2
 4cf:	e8 1c 04 00 00       	call   8f0 <printf>
  if(cid <=0)
 4d4:	83 c4 10             	add    $0x10,%esp
 4d7:	85 db                	test   %ebx,%ebx
 4d9:	7e 0d                	jle    4e8 <ls+0x48>
}
 4db:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4de:	5b                   	pop    %ebx
 4df:	5e                   	pop    %esi
 4e0:	5d                   	pop    %ebp
 4e1:	c3                   	ret    
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4eb:	89 f0                	mov    %esi,%eax
 4ed:	5b                   	pop    %ebx
 4ee:	5e                   	pop    %esi
 4ef:	5d                   	pop    %ebp
 4f0:	e9 8b fc ff ff       	jmp    180 <ls.part.0>
 4f5:	66 90                	xchg   %ax,%ax
 4f7:	66 90                	xchg   %ax,%ax
 4f9:	66 90                	xchg   %ax,%ax
 4fb:	66 90                	xchg   %ax,%ax
 4fd:	66 90                	xchg   %ax,%ax
 4ff:	90                   	nop

00000500 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 45 08             	mov    0x8(%ebp),%eax
 507:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 50a:	89 c2                	mov    %eax,%edx
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	83 c1 01             	add    $0x1,%ecx
 513:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 517:	83 c2 01             	add    $0x1,%edx
 51a:	84 db                	test   %bl,%bl
 51c:	88 5a ff             	mov    %bl,-0x1(%edx)
 51f:	75 ef                	jne    510 <strcpy+0x10>
    ;
  return os;
}
 521:	5b                   	pop    %ebx
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
 524:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 52a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000530 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	53                   	push   %ebx
 534:	8b 55 08             	mov    0x8(%ebp),%edx
 537:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 53a:	0f b6 02             	movzbl (%edx),%eax
 53d:	0f b6 19             	movzbl (%ecx),%ebx
 540:	84 c0                	test   %al,%al
 542:	75 1c                	jne    560 <strcmp+0x30>
 544:	eb 2a                	jmp    570 <strcmp+0x40>
 546:	8d 76 00             	lea    0x0(%esi),%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 550:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 553:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 556:	83 c1 01             	add    $0x1,%ecx
 559:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 55c:	84 c0                	test   %al,%al
 55e:	74 10                	je     570 <strcmp+0x40>
 560:	38 d8                	cmp    %bl,%al
 562:	74 ec                	je     550 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 564:	29 d8                	sub    %ebx,%eax
}
 566:	5b                   	pop    %ebx
 567:	5d                   	pop    %ebp
 568:	c3                   	ret    
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 570:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 572:	29 d8                	sub    %ebx,%eax
}
 574:	5b                   	pop    %ebx
 575:	5d                   	pop    %ebp
 576:	c3                   	ret    
 577:	89 f6                	mov    %esi,%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <strlen>:

uint
strlen(const char *s)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 586:	80 39 00             	cmpb   $0x0,(%ecx)
 589:	74 15                	je     5a0 <strlen+0x20>
 58b:	31 d2                	xor    %edx,%edx
 58d:	8d 76 00             	lea    0x0(%esi),%esi
 590:	83 c2 01             	add    $0x1,%edx
 593:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 597:	89 d0                	mov    %edx,%eax
 599:	75 f5                	jne    590 <strlen+0x10>
    ;
  return n;
}
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret    
 59d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 5a0:	31 c0                	xor    %eax,%eax
}
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 5bd:	89 d7                	mov    %edx,%edi
 5bf:	fc                   	cld    
 5c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5c2:	89 d0                	mov    %edx,%eax
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret    
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <strchr>:

char*
strchr(const char *s, char c)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	53                   	push   %ebx
 5d4:	8b 45 08             	mov    0x8(%ebp),%eax
 5d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 5da:	0f b6 10             	movzbl (%eax),%edx
 5dd:	84 d2                	test   %dl,%dl
 5df:	74 1d                	je     5fe <strchr+0x2e>
    if(*s == c)
 5e1:	38 d3                	cmp    %dl,%bl
 5e3:	89 d9                	mov    %ebx,%ecx
 5e5:	75 0d                	jne    5f4 <strchr+0x24>
 5e7:	eb 17                	jmp    600 <strchr+0x30>
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5f0:	38 ca                	cmp    %cl,%dl
 5f2:	74 0c                	je     600 <strchr+0x30>
  for(; *s; s++)
 5f4:	83 c0 01             	add    $0x1,%eax
 5f7:	0f b6 10             	movzbl (%eax),%edx
 5fa:	84 d2                	test   %dl,%dl
 5fc:	75 f2                	jne    5f0 <strchr+0x20>
      return (char*)s;
  return 0;
 5fe:	31 c0                	xor    %eax,%eax
}
 600:	5b                   	pop    %ebx
 601:	5d                   	pop    %ebp
 602:	c3                   	ret    
 603:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <gets>:

char*
gets(char *buf, int max)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 616:	31 f6                	xor    %esi,%esi
 618:	89 f3                	mov    %esi,%ebx
{
 61a:	83 ec 1c             	sub    $0x1c,%esp
 61d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 620:	eb 2f                	jmp    651 <gets+0x41>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 628:	8d 45 e7             	lea    -0x19(%ebp),%eax
 62b:	83 ec 04             	sub    $0x4,%esp
 62e:	6a 01                	push   $0x1
 630:	50                   	push   %eax
 631:	6a 00                	push   $0x0
 633:	e8 32 01 00 00       	call   76a <read>
    if(cc < 1)
 638:	83 c4 10             	add    $0x10,%esp
 63b:	85 c0                	test   %eax,%eax
 63d:	7e 1c                	jle    65b <gets+0x4b>
      break;
    buf[i++] = c;
 63f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 643:	83 c7 01             	add    $0x1,%edi
 646:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 649:	3c 0a                	cmp    $0xa,%al
 64b:	74 23                	je     670 <gets+0x60>
 64d:	3c 0d                	cmp    $0xd,%al
 64f:	74 1f                	je     670 <gets+0x60>
  for(i=0; i+1 < max; ){
 651:	83 c3 01             	add    $0x1,%ebx
 654:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 657:	89 fe                	mov    %edi,%esi
 659:	7c cd                	jl     628 <gets+0x18>
 65b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 660:	c6 03 00             	movb   $0x0,(%ebx)
}
 663:	8d 65 f4             	lea    -0xc(%ebp),%esp
 666:	5b                   	pop    %ebx
 667:	5e                   	pop    %esi
 668:	5f                   	pop    %edi
 669:	5d                   	pop    %ebp
 66a:	c3                   	ret    
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 670:	8b 75 08             	mov    0x8(%ebp),%esi
 673:	8b 45 08             	mov    0x8(%ebp),%eax
 676:	01 de                	add    %ebx,%esi
 678:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 67a:	c6 03 00             	movb   $0x0,(%ebx)
}
 67d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 680:	5b                   	pop    %ebx
 681:	5e                   	pop    %esi
 682:	5f                   	pop    %edi
 683:	5d                   	pop    %ebp
 684:	c3                   	ret    
 685:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000690 <stat>:

int
stat(const char *n, struct stat *st)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	56                   	push   %esi
 694:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 695:	83 ec 08             	sub    $0x8,%esp
 698:	6a 00                	push   $0x0
 69a:	ff 75 08             	pushl  0x8(%ebp)
 69d:	e8 f0 00 00 00       	call   792 <open>
  if(fd < 0)
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	85 c0                	test   %eax,%eax
 6a7:	78 27                	js     6d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6a9:	83 ec 08             	sub    $0x8,%esp
 6ac:	ff 75 0c             	pushl  0xc(%ebp)
 6af:	89 c3                	mov    %eax,%ebx
 6b1:	50                   	push   %eax
 6b2:	e8 f3 00 00 00       	call   7aa <fstat>
  close(fd);
 6b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ba:	89 c6                	mov    %eax,%esi
  close(fd);
 6bc:	e8 b9 00 00 00       	call   77a <close>
  return r;
 6c1:	83 c4 10             	add    $0x10,%esp
}
 6c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6c7:	89 f0                	mov    %esi,%eax
 6c9:	5b                   	pop    %ebx
 6ca:	5e                   	pop    %esi
 6cb:	5d                   	pop    %ebp
 6cc:	c3                   	ret    
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6d5:	eb ed                	jmp    6c4 <stat+0x34>
 6d7:	89 f6                	mov    %esi,%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <atoi>:

int
atoi(const char *s)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e7:	0f be 11             	movsbl (%ecx),%edx
 6ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 6ed:	3c 09                	cmp    $0x9,%al
  n = 0;
 6ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 6f4:	77 1f                	ja     715 <atoi+0x35>
 6f6:	8d 76 00             	lea    0x0(%esi),%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 700:	8d 04 80             	lea    (%eax,%eax,4),%eax
 703:	83 c1 01             	add    $0x1,%ecx
 706:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 70a:	0f be 11             	movsbl (%ecx),%edx
 70d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 710:	80 fb 09             	cmp    $0x9,%bl
 713:	76 eb                	jbe    700 <atoi+0x20>
  return n;
}
 715:	5b                   	pop    %ebx
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	56                   	push   %esi
 724:	53                   	push   %ebx
 725:	8b 5d 10             	mov    0x10(%ebp),%ebx
 728:	8b 45 08             	mov    0x8(%ebp),%eax
 72b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 72e:	85 db                	test   %ebx,%ebx
 730:	7e 14                	jle    746 <memmove+0x26>
 732:	31 d2                	xor    %edx,%edx
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 738:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 73c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 73f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 742:	39 d3                	cmp    %edx,%ebx
 744:	75 f2                	jne    738 <memmove+0x18>
  return vdst;
}
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5d                   	pop    %ebp
 749:	c3                   	ret    

0000074a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 74a:	b8 01 00 00 00       	mov    $0x1,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <exit>:
SYSCALL(exit)
 752:	b8 02 00 00 00       	mov    $0x2,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <wait>:
SYSCALL(wait)
 75a:	b8 03 00 00 00       	mov    $0x3,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <pipe>:
SYSCALL(pipe)
 762:	b8 04 00 00 00       	mov    $0x4,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <read>:
SYSCALL(read)
 76a:	b8 05 00 00 00       	mov    $0x5,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <write>:
SYSCALL(write)
 772:	b8 10 00 00 00       	mov    $0x10,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    

0000077a <close>:
SYSCALL(close)
 77a:	b8 15 00 00 00       	mov    $0x15,%eax
 77f:	cd 40                	int    $0x40
 781:	c3                   	ret    

00000782 <kill>:
SYSCALL(kill)
 782:	b8 06 00 00 00       	mov    $0x6,%eax
 787:	cd 40                	int    $0x40
 789:	c3                   	ret    

0000078a <exec>:
SYSCALL(exec)
 78a:	b8 07 00 00 00       	mov    $0x7,%eax
 78f:	cd 40                	int    $0x40
 791:	c3                   	ret    

00000792 <open>:
SYSCALL(open)
 792:	b8 0f 00 00 00       	mov    $0xf,%eax
 797:	cd 40                	int    $0x40
 799:	c3                   	ret    

0000079a <mknod>:
SYSCALL(mknod)
 79a:	b8 11 00 00 00       	mov    $0x11,%eax
 79f:	cd 40                	int    $0x40
 7a1:	c3                   	ret    

000007a2 <unlink>:
SYSCALL(unlink)
 7a2:	b8 12 00 00 00       	mov    $0x12,%eax
 7a7:	cd 40                	int    $0x40
 7a9:	c3                   	ret    

000007aa <fstat>:
SYSCALL(fstat)
 7aa:	b8 08 00 00 00       	mov    $0x8,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <link>:
SYSCALL(link)
 7b2:	b8 13 00 00 00       	mov    $0x13,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <mkdir>:
SYSCALL(mkdir)
 7ba:	b8 14 00 00 00       	mov    $0x14,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <chdir>:
SYSCALL(chdir)
 7c2:	b8 09 00 00 00       	mov    $0x9,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <dup>:
SYSCALL(dup)
 7ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <getpid>:
SYSCALL(getpid)
 7d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <sbrk>:
SYSCALL(sbrk)
 7da:	b8 0c 00 00 00       	mov    $0xc,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <sleep>:
SYSCALL(sleep)
 7e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <uptime>:
SYSCALL(uptime)
 7ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <halt>:
SYSCALL(halt)
 7f2:	b8 16 00 00 00       	mov    $0x16,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <toggle>:
SYSCALL(toggle)
 7fa:	b8 17 00 00 00       	mov    $0x17,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <ps>:
SYSCALL(ps)
 802:	b8 18 00 00 00       	mov    $0x18,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <create_container>:
SYSCALL(create_container)
 80a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <destroy_container>:
SYSCALL(destroy_container)
 812:	b8 19 00 00 00       	mov    $0x19,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <join_container>:
SYSCALL(join_container)
 81a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <leave_container>:
SYSCALL(leave_container)
 822:	b8 1b 00 00 00       	mov    $0x1b,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <send>:
SYSCALL(send)
 82a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <recv>:
SYSCALL(recv)
 832:	b8 1e 00 00 00       	mov    $0x1e,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <getcid>:
SYSCALL(getcid)
 83a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    
 842:	66 90                	xchg   %ax,%ax
 844:	66 90                	xchg   %ax,%ax
 846:	66 90                	xchg   %ax,%ax
 848:	66 90                	xchg   %ax,%ax
 84a:	66 90                	xchg   %ax,%ax
 84c:	66 90                	xchg   %ax,%ax
 84e:	66 90                	xchg   %ax,%ax

00000850 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
 855:	53                   	push   %ebx
 856:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 859:	85 d2                	test   %edx,%edx
{
 85b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 85e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 860:	79 76                	jns    8d8 <printint+0x88>
 862:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 866:	74 70                	je     8d8 <printint+0x88>
    x = -xx;
 868:	f7 d8                	neg    %eax
    neg = 1;
 86a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 871:	31 f6                	xor    %esi,%esi
 873:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 876:	eb 0a                	jmp    882 <printint+0x32>
 878:	90                   	nop
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 880:	89 fe                	mov    %edi,%esi
 882:	31 d2                	xor    %edx,%edx
 884:	8d 7e 01             	lea    0x1(%esi),%edi
 887:	f7 f1                	div    %ecx
 889:	0f b6 92 c4 0c 00 00 	movzbl 0xcc4(%edx),%edx
  }while((x /= base) != 0);
 890:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 892:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 895:	75 e9                	jne    880 <printint+0x30>
  if(neg)
 897:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 89a:	85 c0                	test   %eax,%eax
 89c:	74 08                	je     8a6 <printint+0x56>
    buf[i++] = '-';
 89e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 8a3:	8d 7e 02             	lea    0x2(%esi),%edi
 8a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 8aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
 8b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 8b3:	83 ec 04             	sub    $0x4,%esp
 8b6:	83 ee 01             	sub    $0x1,%esi
 8b9:	6a 01                	push   $0x1
 8bb:	53                   	push   %ebx
 8bc:	57                   	push   %edi
 8bd:	88 45 d7             	mov    %al,-0x29(%ebp)
 8c0:	e8 ad fe ff ff       	call   772 <write>

  while(--i >= 0)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	39 de                	cmp    %ebx,%esi
 8ca:	75 e4                	jne    8b0 <printint+0x60>
    putc(fd, buf[i]);
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8df:	eb 90                	jmp    871 <printint+0x21>
 8e1:	eb 0d                	jmp    8f0 <printf>
 8e3:	90                   	nop
 8e4:	90                   	nop
 8e5:	90                   	nop
 8e6:	90                   	nop
 8e7:	90                   	nop
 8e8:	90                   	nop
 8e9:	90                   	nop
 8ea:	90                   	nop
 8eb:	90                   	nop
 8ec:	90                   	nop
 8ed:	90                   	nop
 8ee:	90                   	nop
 8ef:	90                   	nop

000008f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8fc:	0f b6 1e             	movzbl (%esi),%ebx
 8ff:	84 db                	test   %bl,%bl
 901:	0f 84 b3 00 00 00    	je     9ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 907:	8d 45 10             	lea    0x10(%ebp),%eax
 90a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 90d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 90f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 912:	eb 2f                	jmp    943 <printf+0x53>
 914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 918:	83 f8 25             	cmp    $0x25,%eax
 91b:	0f 84 a7 00 00 00    	je     9c8 <printf+0xd8>
  write(fd, &c, 1);
 921:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 924:	83 ec 04             	sub    $0x4,%esp
 927:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 92a:	6a 01                	push   $0x1
 92c:	50                   	push   %eax
 92d:	ff 75 08             	pushl  0x8(%ebp)
 930:	e8 3d fe ff ff       	call   772 <write>
 935:	83 c4 10             	add    $0x10,%esp
 938:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 93b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 93f:	84 db                	test   %bl,%bl
 941:	74 77                	je     9ba <printf+0xca>
    if(state == 0){
 943:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 945:	0f be cb             	movsbl %bl,%ecx
 948:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 94b:	74 cb                	je     918 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 94d:	83 ff 25             	cmp    $0x25,%edi
 950:	75 e6                	jne    938 <printf+0x48>
      if(c == 'd'){
 952:	83 f8 64             	cmp    $0x64,%eax
 955:	0f 84 05 01 00 00    	je     a60 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 95b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 961:	83 f9 70             	cmp    $0x70,%ecx
 964:	74 72                	je     9d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 966:	83 f8 73             	cmp    $0x73,%eax
 969:	0f 84 99 00 00 00    	je     a08 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 96f:	83 f8 63             	cmp    $0x63,%eax
 972:	0f 84 08 01 00 00    	je     a80 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 978:	83 f8 25             	cmp    $0x25,%eax
 97b:	0f 84 ef 00 00 00    	je     a70 <printf+0x180>
  write(fd, &c, 1);
 981:	8d 45 e7             	lea    -0x19(%ebp),%eax
 984:	83 ec 04             	sub    $0x4,%esp
 987:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 98b:	6a 01                	push   $0x1
 98d:	50                   	push   %eax
 98e:	ff 75 08             	pushl  0x8(%ebp)
 991:	e8 dc fd ff ff       	call   772 <write>
 996:	83 c4 0c             	add    $0xc,%esp
 999:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 99c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 99f:	6a 01                	push   $0x1
 9a1:	50                   	push   %eax
 9a2:	ff 75 08             	pushl  0x8(%ebp)
 9a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9aa:	e8 c3 fd ff ff       	call   772 <write>
  for(i = 0; fmt[i]; i++){
 9af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 9b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 9b6:	84 db                	test   %bl,%bl
 9b8:	75 89                	jne    943 <printf+0x53>
    }
  }
}
 9ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9bd:	5b                   	pop    %ebx
 9be:	5e                   	pop    %esi
 9bf:	5f                   	pop    %edi
 9c0:	5d                   	pop    %ebp
 9c1:	c3                   	ret    
 9c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9c8:	bf 25 00 00 00       	mov    $0x25,%edi
 9cd:	e9 66 ff ff ff       	jmp    938 <printf+0x48>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9d8:	83 ec 0c             	sub    $0xc,%esp
 9db:	b9 10 00 00 00       	mov    $0x10,%ecx
 9e0:	6a 00                	push   $0x0
 9e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9e5:	8b 45 08             	mov    0x8(%ebp),%eax
 9e8:	8b 17                	mov    (%edi),%edx
 9ea:	e8 61 fe ff ff       	call   850 <printint>
        ap++;
 9ef:	89 f8                	mov    %edi,%eax
 9f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9f4:	31 ff                	xor    %edi,%edi
        ap++;
 9f6:	83 c0 04             	add    $0x4,%eax
 9f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9fc:	e9 37 ff ff ff       	jmp    938 <printf+0x48>
 a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a0b:	8b 08                	mov    (%eax),%ecx
        ap++;
 a0d:	83 c0 04             	add    $0x4,%eax
 a10:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 a13:	85 c9                	test   %ecx,%ecx
 a15:	0f 84 8e 00 00 00    	je     aa9 <printf+0x1b9>
        while(*s != 0){
 a1b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 a1e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a20:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a22:	84 c0                	test   %al,%al
 a24:	0f 84 0e ff ff ff    	je     938 <printf+0x48>
 a2a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a2d:	89 de                	mov    %ebx,%esi
 a2f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a32:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a35:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a38:	83 ec 04             	sub    $0x4,%esp
          s++;
 a3b:	83 c6 01             	add    $0x1,%esi
 a3e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a41:	6a 01                	push   $0x1
 a43:	57                   	push   %edi
 a44:	53                   	push   %ebx
 a45:	e8 28 fd ff ff       	call   772 <write>
        while(*s != 0){
 a4a:	0f b6 06             	movzbl (%esi),%eax
 a4d:	83 c4 10             	add    $0x10,%esp
 a50:	84 c0                	test   %al,%al
 a52:	75 e4                	jne    a38 <printf+0x148>
 a54:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a57:	31 ff                	xor    %edi,%edi
 a59:	e9 da fe ff ff       	jmp    938 <printf+0x48>
 a5e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a60:	83 ec 0c             	sub    $0xc,%esp
 a63:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a68:	6a 01                	push   $0x1
 a6a:	e9 73 ff ff ff       	jmp    9e2 <printf+0xf2>
 a6f:	90                   	nop
  write(fd, &c, 1);
 a70:	83 ec 04             	sub    $0x4,%esp
 a73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a79:	6a 01                	push   $0x1
 a7b:	e9 21 ff ff ff       	jmp    9a1 <printf+0xb1>
        putc(fd, *ap);
 a80:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a86:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a88:	6a 01                	push   $0x1
        ap++;
 a8a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a93:	50                   	push   %eax
 a94:	ff 75 08             	pushl  0x8(%ebp)
 a97:	e8 d6 fc ff ff       	call   772 <write>
        ap++;
 a9c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a9f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 aa2:	31 ff                	xor    %edi,%edi
 aa4:	e9 8f fe ff ff       	jmp    938 <printf+0x48>
          s = "(null)";
 aa9:	bb bc 0c 00 00       	mov    $0xcbc,%ebx
        while(*s != 0){
 aae:	b8 28 00 00 00       	mov    $0x28,%eax
 ab3:	e9 72 ff ff ff       	jmp    a2a <printf+0x13a>
 ab8:	66 90                	xchg   %ax,%ax
 aba:	66 90                	xchg   %ax,%ax
 abc:	66 90                	xchg   %ax,%ax
 abe:	66 90                	xchg   %ax,%ax

00000ac0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac1:	a1 70 10 00 00       	mov    0x1070,%eax
{
 ac6:	89 e5                	mov    %esp,%ebp
 ac8:	57                   	push   %edi
 ac9:	56                   	push   %esi
 aca:	53                   	push   %ebx
 acb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 ace:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad8:	39 c8                	cmp    %ecx,%eax
 ada:	8b 10                	mov    (%eax),%edx
 adc:	73 32                	jae    b10 <free+0x50>
 ade:	39 d1                	cmp    %edx,%ecx
 ae0:	72 04                	jb     ae6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae2:	39 d0                	cmp    %edx,%eax
 ae4:	72 32                	jb     b18 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ae6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ae9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aec:	39 fa                	cmp    %edi,%edx
 aee:	74 30                	je     b20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 af0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 af3:	8b 50 04             	mov    0x4(%eax),%edx
 af6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 af9:	39 f1                	cmp    %esi,%ecx
 afb:	74 3a                	je     b37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 afd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 aff:	a3 70 10 00 00       	mov    %eax,0x1070
}
 b04:	5b                   	pop    %ebx
 b05:	5e                   	pop    %esi
 b06:	5f                   	pop    %edi
 b07:	5d                   	pop    %ebp
 b08:	c3                   	ret    
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b10:	39 d0                	cmp    %edx,%eax
 b12:	72 04                	jb     b18 <free+0x58>
 b14:	39 d1                	cmp    %edx,%ecx
 b16:	72 ce                	jb     ae6 <free+0x26>
{
 b18:	89 d0                	mov    %edx,%eax
 b1a:	eb bc                	jmp    ad8 <free+0x18>
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b20:	03 72 04             	add    0x4(%edx),%esi
 b23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b26:	8b 10                	mov    (%eax),%edx
 b28:	8b 12                	mov    (%edx),%edx
 b2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b2d:	8b 50 04             	mov    0x4(%eax),%edx
 b30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b33:	39 f1                	cmp    %esi,%ecx
 b35:	75 c6                	jne    afd <free+0x3d>
    p->s.size += bp->s.size;
 b37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b3a:	a3 70 10 00 00       	mov    %eax,0x1070
    p->s.size += bp->s.size;
 b3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b42:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b45:	89 10                	mov    %edx,(%eax)
}
 b47:	5b                   	pop    %ebx
 b48:	5e                   	pop    %esi
 b49:	5f                   	pop    %edi
 b4a:	5d                   	pop    %ebp
 b4b:	c3                   	ret    
 b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b5c:	8b 15 70 10 00 00    	mov    0x1070,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b62:	8d 78 07             	lea    0x7(%eax),%edi
 b65:	c1 ef 03             	shr    $0x3,%edi
 b68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b6b:	85 d2                	test   %edx,%edx
 b6d:	0f 84 9d 00 00 00    	je     c10 <malloc+0xc0>
 b73:	8b 02                	mov    (%edx),%eax
 b75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b78:	39 cf                	cmp    %ecx,%edi
 b7a:	76 6c                	jbe    be8 <malloc+0x98>
 b7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b82:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b87:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b91:	eb 0e                	jmp    ba1 <malloc+0x51>
 b93:	90                   	nop
 b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b9a:	8b 48 04             	mov    0x4(%eax),%ecx
 b9d:	39 f9                	cmp    %edi,%ecx
 b9f:	73 47                	jae    be8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ba1:	39 05 70 10 00 00    	cmp    %eax,0x1070
 ba7:	89 c2                	mov    %eax,%edx
 ba9:	75 ed                	jne    b98 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bab:	83 ec 0c             	sub    $0xc,%esp
 bae:	56                   	push   %esi
 baf:	e8 26 fc ff ff       	call   7da <sbrk>
  if(p == (char*)-1)
 bb4:	83 c4 10             	add    $0x10,%esp
 bb7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bba:	74 1c                	je     bd8 <malloc+0x88>
  hp->s.size = nu;
 bbc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bbf:	83 ec 0c             	sub    $0xc,%esp
 bc2:	83 c0 08             	add    $0x8,%eax
 bc5:	50                   	push   %eax
 bc6:	e8 f5 fe ff ff       	call   ac0 <free>
  return freep;
 bcb:	8b 15 70 10 00 00    	mov    0x1070,%edx
      if((p = morecore(nunits)) == 0)
 bd1:	83 c4 10             	add    $0x10,%esp
 bd4:	85 d2                	test   %edx,%edx
 bd6:	75 c0                	jne    b98 <malloc+0x48>
        return 0;
  }
}
 bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bdb:	31 c0                	xor    %eax,%eax
}
 bdd:	5b                   	pop    %ebx
 bde:	5e                   	pop    %esi
 bdf:	5f                   	pop    %edi
 be0:	5d                   	pop    %ebp
 be1:	c3                   	ret    
 be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 be8:	39 cf                	cmp    %ecx,%edi
 bea:	74 54                	je     c40 <malloc+0xf0>
        p->s.size -= nunits;
 bec:	29 f9                	sub    %edi,%ecx
 bee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bf1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bf4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bf7:	89 15 70 10 00 00    	mov    %edx,0x1070
}
 bfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c00:	83 c0 08             	add    $0x8,%eax
}
 c03:	5b                   	pop    %ebx
 c04:	5e                   	pop    %esi
 c05:	5f                   	pop    %edi
 c06:	5d                   	pop    %ebp
 c07:	c3                   	ret    
 c08:	90                   	nop
 c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c10:	c7 05 70 10 00 00 74 	movl   $0x1074,0x1070
 c17:	10 00 00 
 c1a:	c7 05 74 10 00 00 74 	movl   $0x1074,0x1074
 c21:	10 00 00 
    base.s.size = 0;
 c24:	b8 74 10 00 00       	mov    $0x1074,%eax
 c29:	c7 05 78 10 00 00 00 	movl   $0x0,0x1078
 c30:	00 00 00 
 c33:	e9 44 ff ff ff       	jmp    b7c <malloc+0x2c>
 c38:	90                   	nop
 c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c40:	8b 08                	mov    (%eax),%ecx
 c42:	89 0a                	mov    %ecx,(%edx)
 c44:	eb b1                	jmp    bf7 <malloc+0xa7>
