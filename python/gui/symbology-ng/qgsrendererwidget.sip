class QgsRendererWidget : QgsPanelWidget
{
%TypeHeaderCode
#include <qgsrendererwidget.h>
%End

  public:
    QgsRendererWidget( QgsVectorLayer *layer, QgsStyle *style );

    virtual ~QgsRendererWidget();

    //! return pointer to the renderer (no transfer of ownership)
    virtual QgsFeatureRenderer *renderer() = 0;

    //! show a dialog with renderer's symbol level settings
    void showSymbolLevelsDialog( QgsFeatureRenderer *r );

    /** Sets the context in which the symbol widget is shown, e.g., the associated map canvas and expression contexts.
     * @param context symbol widget context
     * @see context()
     * @note added in QGIS 3.0
     */
    void setContext( const QgsSymbolWidgetContext &context );

    /** Returns the context in which the symbol widget is shown, e.g., the associated map canvas and expression contexts.
     * @see setContext()
     * @note added in QGIS 3.0
     */
    QgsSymbolWidgetContext context() const;

    /** Returns the vector layer associated with the widget.
     * @note added in QGIS 2.12
     */
    const QgsVectorLayer *vectorLayer() const;

    /**
     * This method should be called whenever the renderer is actually set on the layer.
     */
    void applyChanges();

  signals:
    /**
     * Emitted when expression context variables on the associated
     * vector layers have been changed. Will request the parent dialog
     * to re-synchronize with the variables.
     */
    void layerVariablesChanged();

  protected:
    /** Subclasses may provide the capability of changing multiple symbols at once by implementing the following two methods
      and by connecting the slot contextMenuViewCategories(const QPoint&)*/
    virtual QList<QgsSymbol*> selectedSymbols();
    virtual void refreshSymbolView();

  protected slots:
    void  contextMenuViewCategories( QPoint p );
    /** Change color of selected symbols*/
    void changeSymbolColor();
    /** Change opacity of selected symbols*/
    void changeSymbolOpacity();
    /** Change units mm/map units of selected symbols*/
    void changeSymbolUnit();
    /** Change line widths of selected symbols*/
    void changeSymbolWidth();
    /** Change marker sizes of selected symbols*/
    void changeSymbolSize();
    /** Change marker angles of selected symbols*/
    void changeSymbolAngle();

    virtual void copy();
    virtual void paste();

  private:
    /**
     * This will be called whenever the renderer is set on a layer.
     * This can be overwritten in subclasses.
     */
    virtual void apply();

};


/**
Utility classes for "en masse" size definition
*/
class QgsDataDefinedValueDialog : QDialog
{
%TypeHeaderCode
#include <qgsrendererwidget.h>
%End

  public:
    /** Constructor
     * @param symbolList must not be empty
     * @param layer must not be null
     * @param label value label
     */
    QgsDataDefinedValueDialog( const QList<QgsSymbol*> &symbolList, QgsVectorLayer *layer, const QString &label );
    virtual ~QgsDataDefinedValueDialog();

    /** Sets the context in which the symbol widget is shown, e.g., the associated map canvas and expression contexts.
     * @param context symbol widget context
     * @see context()
     * @note added in QGIS 3.0
     */
    void setContext( const QgsSymbolWidgetContext &context );

    /** Returns the context in which the symbol widget is shown, e.g., the associated map canvas and expression contexts.
     * @see setContext()
     * @note added in QGIS 3.0
     */
    QgsSymbolWidgetContext context() const;

    /** Returns the vector layer associated with the widget.
     * @note added in QGIS 2.12
     */
    const QgsVectorLayer *vectorLayer() const;

  public slots:
    void dataDefinedChanged();

  protected:
    /**
     * Should be called in the constructor of child classes.
     *
     * @note May be missing Python bindings depending on the platform.
     */
    void init( int propertyKey ); // needed in children ctor to call virtual

  private:
    QgsProperty symbolDataDefined() const;
    virtual QgsProperty symbolDataDefined( const QgsSymbol* ) const = 0;
    virtual double value( const QgsSymbol* ) const = 0;
    virtual void setDataDefined( QgsSymbol *symbol, const QgsProperty &dd ) = 0;
};

class QgsDataDefinedSizeDialog : QgsDataDefinedValueDialog
{
%TypeHeaderCode
#include <qgsrendererwidget.h>
%End

  public:
    QgsDataDefinedSizeDialog( const QList<QgsSymbol*> &symbolList, QgsVectorLayer *layer );

  protected:
    virtual QgsProperty symbolDataDefined( const QgsSymbol* ) const;

    double value( const QgsSymbol *symbol ) const;

    void setDataDefined( QgsSymbol *symbol, const QgsProperty &dd );
};

class QgsDataDefinedRotationDialog : QgsDataDefinedValueDialog
{
%TypeHeaderCode
#include <qgsrendererwidget.h>
%End

  public:
    QgsDataDefinedRotationDialog( const QList<QgsSymbol*> &symbolList, QgsVectorLayer *layer );

  protected:
    virtual QgsProperty symbolDataDefined( const QgsSymbol* ) const;

    double value( const QgsSymbol *symbol ) const;

    void setDataDefined( QgsSymbol *symbol, const QgsProperty &dd );
};


class QgsDataDefinedWidthDialog : QgsDataDefinedValueDialog
{
%TypeHeaderCode
#include <qgsrendererwidget.h>
%End

  public:
    QgsDataDefinedWidthDialog( const QList<QgsSymbol*> &symbolList, QgsVectorLayer *layer );

  protected:
    virtual QgsProperty symbolDataDefined( const QgsSymbol* ) const;

    double value( const QgsSymbol *symbol ) const;

    void setDataDefined( QgsSymbol *symbol, const QgsProperty &dd );
};
