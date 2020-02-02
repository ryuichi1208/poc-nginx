while [ "$#" -gt 0 ]; do
    case $1 in
        --initrd)
            shift 1
            INITRD_FILE=$(readlink -f $1)
            ;;
        --img)
            shift 1
            IMG_FILE=$(readlink -f $1)
            ;;
        --cert)
            shift 1
            CERT_FILE=$(readlink -f $1)
            ;;
        *)
            break
            ;;
    esac
    shift 1
done

function rebuild_initrd() {
    local initrd_name=$1
    local output_dir=$2

    # update and rebuild the initrd
    pushd ${WORK_DIR}
    mv initrd-* ${initrd_name}.gz
    gzip -d ${initrd_name}.gz
    cpio -i -F ${initrd_name}
    rm -f ${initrd_name}
    cat ${CERT_FILE} >> ${WORK_DIR}/usr/etc/ssl/certs/ca-certificates.crt
    find | cpio -H newc -o | gzip -9 > ${output_dir}/${initrd_name}
    popd
}
