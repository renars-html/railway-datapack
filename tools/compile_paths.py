"""Compile fixed-point interpolation metadata into existing fixture path functions.
Run from any directory. Minecraft ignores this development-only .py file.
"""
from pathlib import Path
import json,math
ROOT=Path(__file__).resolve().parents[1]
def compile_file(profile):
 path=ROOT/f'data/railway/function/dev/internal/path_{profile}_load.mcfunction'
 lines=path.read_text().splitlines();frames=[]
 for line in lines:
  if line.startswith(('data modify storage railway:dev_path frames set value ', 'data modify storage railway:dev_path chunk set value ')):
   frames.extend(json.loads(line.split(' set value ',1)[1]))
 assert frames
 for i,frame in enumerate(frames):
  nxt=frames[(i+1)%len(frames)]
  axes=''
  for axis in 'xyz':
   a=math.floor(frame[axis]*10000);b=math.floor(nxt[axis]*10000)
   frame['a'+axis]=a;frame['d'+axis]=b-a
   if b!=a:axes+=axis
  frame['axes']=axes or 'none'
 # Preserve route metrics/constants, replace only sample declarations and chunk cleanup.
 prefix=[]
 for line in lines:
  if line.startswith(('data modify storage railway:dev_path frames set value ', 'data modify storage railway:dev_path chunk set value ', 'data modify storage railway:dev_path frames append ', 'data remove storage railway:dev_path chunk')):continue
  prefix.append(line)
 result=prefix+['data modify storage railway:dev_path frames set value []']
 for start in range(0,len(frames),100):
  result+=['data modify storage railway:dev_path chunk set value '+json.dumps(frames[start:start+100],separators=(',',':')),'data modify storage railway:dev_path frames append from storage railway:dev_path chunk[]']
 result+=['data remove storage railway:dev_path chunk']
 path.write_text('\n'.join(result)+'\n')
 return len(frames)
if __name__=='__main__':
 for profile in ('small','large'):print(profile,compile_file(profile),'compiled samples')
