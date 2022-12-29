#!/bin/bash
ln -s /data/Former-DFER/all_clips /Former-DFER/all_clips
mv -f /data/.pth/former_trained.pth /Former-DFER/checkpoint/trained.pth 2>/dev/null
mv -f /data/.pth/l2cs_trained.pkl /L2CS-Net/models/trained.pkl 2>/dev/null

echo "RUNNING!!!"
git -C /RITnet pull -q
git -C /L2CS-Net pull -q
git -C /Former-DFER pull -q

exec "$@"  # cause the shell to run it's command line parameter, which is "CMD ["/bin/bash"]
