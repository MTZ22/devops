apiVersion: apps/v1
kind: Deployment
metadata:
  name: sftp
  namespace: ns-sftp
spec:
  replicas: 1 #可自行修改副本的个数
  selector:
    matchLabels:
      app: sftp
  template:
    metadata:
      labels:
        app: sftp
    spec:
      containers:
      - command: ["/entrypoint", "$(user):$(passwd):::$(path)"]
        image: atmoz/sftp:alpine
        name: sftp
        env:
        - name: user
          valueFrom:
            secretKeyRef:
              name: sftp-secret
              key: sftp_user
        - name: passwd
          valueFrom:
            secretKeyRef:
              name: sftp-secret
              key: sftp_password
        - name: path
          value: "socialhub"
        resources:
          limits:
            cpu: "1"
            memory: 200Mi
          requests:
            cpu: "0.5"
            memory: 100Mi
        volumeMounts:
        - mountPath: /etc/ssh/ssh_host_ed25519_key
          name: ssh-host-ed25519-key
        - mountPath: /etc/ssh/ssh_host_rsa_key
          name: ssh-host-rsa-key
          #        - name: sftp-ssh-ed25519-key
          #          mountPath: /etc/ssh/ssh_host_ed25519_key
          #          subPath: ssh_host_ed25519_key
          #        - name: sftp-ssh-rsa-key
          #          mountPath: /etc/ssh/ssh_host_rsa_key
          #          subPath: ssh_host_rsa_key
      volumes:
      - hostPath:
          path: /etc/ssh/ssh_host_ed25519_key
        name: ssh-host-ed25519-key
      - hostPath:
          path: /etc/ssh/ssh_host_rsa_key
        name: ssh-host-rsa-key
        #      - name: sftp-ssh-ed25519-key
        #        configMap:
        #          name: sftp-ssh-config
        #          items:
        #            - key: ssh_host_ed25519_key
        #              path: ssh_host_ed25519_key
        #      - name: sftp-ssh-rsa-key
        #        configMap:
        #          name: sftp-ssh-config
        #          items:
        #            - key: ssh_host_rsa_key
        #              path: ssh_host_rsa_key

          #      - name: sftp-roothome
          #          persistentVolumeClaim:
          #            claimName: sftp-pvc
